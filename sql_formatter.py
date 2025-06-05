#!/usr/bin/env python3
"""
Advanced SQL Formatter for Stored Procedures
Formats SQL code with consistent indentation and structure before chunking analysis.
"""

import re
import sys
from typing import List, Tuple, Optional
from dataclasses import dataclass

@dataclass
class FormatSettings:
    """SQL formatting configuration"""
    indent_size: int = 4
    max_line_length: int = 100
    align_select_columns: bool = True
    align_where_conditions: bool = True
    uppercase_keywords: bool = False
    add_spacing_around_operators: bool = True
    normalize_whitespace: bool = True

class SQLFormatter:
    """Advanced SQL formatter with context-aware indentation"""
    
    def __init__(self, settings: FormatSettings = None):
        self.settings = settings or FormatSettings()
        self.reset_state()
        
        # Keywords that increase indentation
        self.indent_increase_keywords = {
            'BEGIN', 'CASE', 'TRY'
        }
        
        # Keywords that decrease indentation
        self.indent_decrease_keywords = {
            'END', 'CATCH'
        }
        
        # Control flow keywords that may increase indentation
        self.control_flow_keywords = {
            'IF', 'ELSE', 'ELSEIF', 'ELSIF', 'WHILE', 'FOR'
        }
        
        # SQL keywords for potential case conversion
        self.sql_keywords = {
            'SELECT', 'FROM', 'WHERE', 'AND', 'OR', 'ORDER BY', 'GROUP BY', 'HAVING',
            'INSERT', 'INTO', 'VALUES', 'UPDATE', 'SET', 'DELETE', 'CREATE', 'ALTER',
            'DROP', 'TABLE', 'VIEW', 'INDEX', 'PROCEDURE', 'FUNCTION', 'TRIGGER',
            'DECLARE', 'BEGIN', 'END', 'IF', 'ELSE', 'WHILE', 'FOR', 'TRY', 'CATCH',
            'CASE', 'WHEN', 'THEN', 'AS', 'ON', 'JOIN', 'LEFT', 'RIGHT', 'INNER',
            'OUTER', 'UNION', 'INTERSECT', 'EXCEPT', 'WITH', 'DISTINCT', 'TOP',
            'IS', 'NULL', 'NOT', 'IN', 'EXISTS', 'LIKE', 'BETWEEN', 'ASC', 'DESC'
        }
        
    def reset_state(self):
        """Reset the formatter state"""
        self.indent_level = 0
        self.base_indent_level = 1  # Start at level 1 for procedure content
        self.in_procedure = False
        
    def format_sql(self, sql_content: str) -> str:
        """Format entire SQL content with consistent indentation"""
        lines = sql_content.split('\n')
        formatted_lines = []
        
        self.reset_state()
        
        for i, line in enumerate(lines):
            formatted_line = self._format_line(line, i, lines)
            if formatted_line is not None:
                formatted_lines.append(formatted_line)
        
        return '\n'.join(formatted_lines)
    
    def _format_line(self, line: str, line_index: int, all_lines: List[str]) -> Optional[str]:
        """Format a single line with proper indentation and structure"""
        original_line = line
        
        # Normalize whitespace
        if self.settings.normalize_whitespace:
            line = re.sub(r'\s+', ' ', line.strip())
        else:
            line = line.strip()
        
        # Skip empty lines but preserve them
        if not line:
            return ''
        
        # Handle comments - maintain current indentation level
        if line.startswith('--') or line.startswith('/*'):
            return self._indent_text(line)
        
        # Detect procedure start
        if re.search(r'\bCREATE\s+PROCEDURE\b', line.upper()):
            self.in_procedure = True
            self.indent_level = 0
            return line  # No indentation for CREATE PROCEDURE
        
        # Process the line for indentation changes
        pre_indent, post_indent = self._calculate_indentation_changes(line)
        
        # Apply pre-indentation change (for ELSE, END, etc.)
        if pre_indent != 0:
            self.indent_level += pre_indent
            if self.indent_level < 0:
                self.indent_level = 0
        
        # Format the line content
        formatted_content = self._format_line_content(line)
        
        # Create the indented line
        effective_indent = self.base_indent_level if self.in_procedure and self.indent_level == 0 else self.base_indent_level + self.indent_level
        indented_line = self._create_indented_line(formatted_content, effective_indent)
        
        # Apply post-indentation change (for BEGIN, IF, etc.)
        if post_indent != 0:
            self.indent_level += post_indent
            if self.indent_level < 0:
                self.indent_level = 0
        
        return indented_line
    
    def _calculate_indentation_changes(self, line: str) -> Tuple[int, int]:
        """Calculate indentation changes before and after processing the line"""
        line_upper = line.upper().strip()
        pre_change = 0
        post_change = 0
        
        # Handle END statements (decrease before)
        if re.search(r'\bEND\b(?!\s+(?:IF|WHILE|FOR|TRY|CATCH|CASE))', line_upper):
            pre_change -= 1
        
        # Handle ELSE, ELSEIF (same level as their opening statement)
        elif re.search(r'\b(ELSE)\b(?!\s+IF)', line_upper):
            pre_change -= 1
            post_change += 1
        elif re.search(r'\b(ELSEIF|ELSIF)\b', line_upper):
            pre_change -= 1
            post_change += 1
        
        # Handle CATCH (same level as TRY)
        elif re.search(r'\bCATCH\b', line_upper):
            pre_change -= 1
            post_change += 1
        
        # Handle statements that increase indentation after
        if re.search(r'\bBEGIN\b', line_upper):
            post_change += 1
        elif re.search(r'\bIF\b', line_upper):
            # Check if it's a complex IF statement (likely multi-line)
            if not self._is_simple_if_statement(line_upper):
                post_change += 1
        elif re.search(r'\b(WHILE|FOR|TRY|CASE)\b', line_upper):
            post_change += 1
        
        return pre_change, post_change
    
    def _is_simple_if_statement(self, line_upper: str) -> bool:
        """Determine if an IF statement is a simple single-line statement"""
        # If the line contains BEGIN or multiple statements, it's complex
        if re.search(r'\bBEGIN\b', line_upper):
            return False
        
        # If it's a simple assignment or single operation on the same line, it's simple
        if re.search(r'\bIF\b.*\b(SET|SELECT|RETURN|GOTO)\b.*[;]?\s*$', line_upper):
            return True
        
        # If the condition is very simple, it might be single-line
        if len(line_upper) < 80 and line_upper.count('(') <= 1:
            return True
        
        # Default to complex for safety
        return False
    
    def _format_line_content(self, line: str) -> str:
        """Format the content of the line (keywords, operators, spacing)"""
        # Add spacing around operators if enabled
        if self.settings.add_spacing_around_operators:
            # Add spaces around common operators
            line = re.sub(r'([a-zA-Z0-9_\]])\s*=\s*([a-zA-Z0-9_@\[\(])', r'\1 = \2', line)
            line = re.sub(r'([a-zA-Z0-9_\]])\s*\+\s*([a-zA-Z0-9_@\[\(])', r'\1 + \2', line)
            line = re.sub(r'([a-zA-Z0-9_\]])\s*-\s*([a-zA-Z0-9_@\[\(])', r'\1 - \2', line)
            line = re.sub(r'([a-zA-Z0-9_\]])\s*\*\s*([a-zA-Z0-9_@\[\(])', r'\1 * \2', line)
            line = re.sub(r'([a-zA-Z0-9_\]])\s*/\s*([a-zA-Z0-9_@\[\(])', r'\1 / \2', line)
        
        # Optionally convert keywords to uppercase
        if self.settings.uppercase_keywords:
            for keyword in self.sql_keywords:
                pattern = r'\b' + re.escape(keyword) + r'\b'
                line = re.sub(pattern, keyword.upper(), line, flags=re.IGNORECASE)
        
        return line
    
    def _indent_text(self, text: str) -> str:
        """Apply the current indentation level to text"""
        effective_indent = self.base_indent_level if self.in_procedure and self.indent_level == 0 else self.base_indent_level + self.indent_level
        return self._create_indented_line(text, effective_indent)
    
    def _create_indented_line(self, text: str, indent_level: int) -> str:
        """Create an indented line with the specified level"""
        indent = ' ' * (indent_level * self.settings.indent_size)
        return indent + text

def format_sql_file(input_file: str, output_file: str = None, settings: FormatSettings = None) -> str:
    """Format a SQL file with consistent indentation"""
    if output_file is None:
        output_file = input_file.replace('.sql', '_formatted.sql')
    
    formatter = SQLFormatter(settings)
    
    # Read the input file
    with open(input_file, 'r', encoding='utf-8', errors='ignore') as f:
        sql_content = f.read()
    
    # Format the content
    formatted_content = formatter.format_sql(sql_content)
    
    # Write the formatted content
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(formatted_content)
    
    print(f"Formatted SQL written to: {output_file}")
    return output_file

def main():
    """Command line interface for SQL formatting"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Format SQL stored procedures with consistent indentation')
    parser.add_argument('input_file', help='Input SQL file to format')
    parser.add_argument('--output', '-o', help='Output file (default: input_formatted.sql)')
    parser.add_argument('--indent-size', type=int, default=4, help='Number of spaces per indentation level')
    parser.add_argument('--uppercase-keywords', action='store_true', help='Convert SQL keywords to uppercase')
    parser.add_argument('--no-align-columns', action='store_true', help='Disable SELECT column alignment')
    parser.add_argument('--no-spacing', action='store_true', help='Disable spacing around operators')
    
    args = parser.parse_args()
    
    # Create format settings
    settings = FormatSettings(
        indent_size=args.indent_size,
        uppercase_keywords=args.uppercase_keywords,
        align_select_columns=not args.no_align_columns,
        add_spacing_around_operators=not args.no_spacing
    )
    
    # Format the file
    output_file = format_sql_file(args.input_file, args.output, settings)
    
    print(f"SQL formatting complete!")
    print(f"Input: {args.input_file}")
    print(f"Output: {output_file}")

if __name__ == "__main__":
    main() 