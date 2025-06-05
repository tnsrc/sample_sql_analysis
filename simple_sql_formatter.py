#!/usr/bin/env python3
"""
Simple SQL Formatter that resets indentation from scratch rather than building on existing indentation
Formats SQL code with clean, consistent indentation starting from zero while preserving original line spacing.
"""

import re
from typing import List

class SimpleSQLFormatter:
    """Simple SQL formatter that resets all indentation while preserving original spacing"""
    
    def __init__(self, indent_size: int = 4):
        self.indent_size = indent_size
        self.indent_level = 0
        
    def format_sql(self, sql_content: str) -> str:
        """Format SQL content with clean indentation while preserving original spacing"""
        lines = sql_content.split('\n')
        formatted_lines = []
        self.indent_level = 0
        
        for line in lines:
            # Preserve empty lines as they were in the original
            if not line.strip():
                formatted_lines.append('')
            else:
                formatted_line = self._format_line(line.strip())
                formatted_lines.append(formatted_line)
        
        # Only remove trailing empty lines, but preserve all internal spacing
        while formatted_lines and not formatted_lines[-1].strip():
            formatted_lines.pop()
        
        return '\n'.join(formatted_lines)
    
    def _format_line(self, line: str) -> str:
        """Format a single line"""
        if not line:
            return ''
        
        # Handle comments
        if line.startswith('--') or line.startswith('/*') or '*/' in line:
            return self._indent(line)
        
        # Handle CREATE PROCEDURE - no indentation
        if re.search(r'\bCREATE\s+PROCEDURE\b', line, re.IGNORECASE):
            self.indent_level = 0
            return line
        
        # Calculate indentation changes
        pre_decrease = self._should_decrease_before(line)
        post_increase = self._should_increase_after(line)
        
        # Apply pre-decrease (for END, ELSE, etc.)
        if pre_decrease:
            self.indent_level -= 1
            if self.indent_level < 0:
                self.indent_level = 0
        
        # Format the line with current indentation
        formatted_line = self._indent(line)
        
        # Apply post-increase (for BEGIN, IF, etc.)
        if post_increase:
            self.indent_level += 1
        
        return formatted_line
    
    def _should_decrease_before(self, line: str) -> bool:
        """Check if indentation should decrease before this line"""
        line_upper = line.upper()
        
        # END statements (but not END IF, END WHILE, etc.)
        if re.search(r'\bEND\b(?!\s+(?:IF|WHILE|FOR|TRY|CATCH|CASE))', line_upper):
            return True
        
        # ELSE (but not ELSE IF)
        if re.search(r'\bELSE\b(?!\s+IF)', line_upper):
            return True
            
        # CATCH
        if re.search(r'\bCATCH\b', line_upper):
            return True
            
        return False
    
    def _should_increase_after(self, line: str) -> bool:
        """Check if indentation should increase after this line"""
        line_upper = line.upper()
        
        # BEGIN
        if re.search(r'\bBEGIN\b', line_upper):
            return True
        
        # IF (but only if it seems to be a block IF, not single-line)
        if re.search(r'\bIF\b', line_upper):
            # If it doesn't contain SET, SELECT, etc. on the same line, it's likely a block IF
            if not re.search(r'\bIF\b.*\b(SET|SELECT|RETURN|GOTO)\b', line_upper):
                return True
        
        # WHILE, FOR, TRY
        if re.search(r'\b(WHILE|FOR|TRY)\b', line_upper):
            return True
            
        # ELSE (increase after ELSE)
        if re.search(r'\bELSE\b', line_upper):
            return True
            
        # CATCH
        if re.search(r'\bCATCH\b', line_upper):
            return True
        
        return False
    
    def _indent(self, line: str) -> str:
        """Apply indentation to a line"""
        # For CREATE PROCEDURE, don't indent
        if re.search(r'\bCREATE\s+PROCEDURE\b', line, re.IGNORECASE):
            return line
            
        # For procedure content, start with base indentation
        indent_spaces = ' ' * (self.indent_level * self.indent_size)
        return indent_spaces + line

def format_sql_file(input_file: str, output_file: str = None) -> str:
    """Format a SQL file with clean indentation"""
    if output_file is None:
        base_name = input_file.replace('.sql', '')
        output_file = f"{base_name}_clean_formatted.sql"
    
    # Read input file
    with open(input_file, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # Format content
    formatter = SimpleSQLFormatter(indent_size=4)
    formatted_content = formatter.format_sql(content)
    
    # Write output file
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(formatted_content)
    
    print(f"Clean formatted SQL written to: {output_file}")
    return output_file

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python simple_sql_formatter.py <input_file.sql>")
        sys.exit(1)
    
    input_file = sys.argv[1]
    format_sql_file(input_file) 