#!/usr/bin/env python3
"""
Universal SQL Stored Procedure Chunked Analyzer
Breaks any large stored procedure into manageable chunks for AI analysis
Works across all business domains and SQL variants.
"""

import re
from typing import List, Dict, Any, Tuple, Optional
from dataclasses import dataclass
import json
from enum import Enum

class ChunkType(Enum):
    """Generic chunk types based on SQL patterns, not business logic"""
    DECLARATION = "variable_declaration"
    VALIDATION = "validation_logic" 
    CONDITIONAL = "conditional_logic"
    LOOP = "loop_logic"
    DATA_RETRIEVAL = "data_retrieval"
    DATA_MODIFICATION = "data_modification"
    CALCULATION = "calculation_logic"
    TRANSACTION = "transaction_control"
    ERROR_HANDLING = "error_handling"
    CURSOR_OPERATION = "cursor_operation"
    DYNAMIC_SQL = "dynamic_sql"
    GENERAL = "general_logic"

@dataclass
class CodeChunk:
    """Represents a logical chunk of code for analysis"""
    chunk_id: int
    title: str
    lines: List[str]
    start_line: int
    end_line: int
    chunk_type: ChunkType
    complexity_score: int
    sql_operations: List[str]  # SELECT, INSERT, UPDATE, DELETE, etc.
    variables_declared: List[str]
    variables_used: List[str]
    tables_accessed: List[str]
    control_structures: List[str]  # IF, WHILE, TRY, etc.
    dependencies: List[int]  # Other chunk IDs this depends on
    
class UniversalSQLAnalyzer:
    def __init__(self, max_chunk_size: int = 50, min_chunk_size: int = 5):
        self.max_chunk_size = max_chunk_size
        self.min_chunk_size = min_chunk_size
        self.chunks = []
        
        # Generic SQL patterns - work for any domain
        self.sql_keywords = {
            'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'MERGE', 'EXEC', 'EXECUTE',
            'CREATE', 'ALTER', 'DROP', 'TRUNCATE', 'BULK'
        }
        
        self.control_keywords = {
            'IF', 'ELSE', 'WHILE', 'FOR', 'BEGIN', 'END', 'TRY', 'CATCH',
            'GOTO', 'RETURN', 'BREAK', 'CONTINUE', 'CASE', 'WHEN'
        }
        
        self.transaction_keywords = {
            'BEGIN TRANSACTION', 'COMMIT', 'ROLLBACK', 'SAVE TRANSACTION'
        }
        
    def chunk_procedure(self, sql_content: str) -> List[CodeChunk]:
        """Break any stored procedure into logical, manageable chunks"""
        lines = sql_content.split('\n')
        
        # Clean and analyze lines
        analyzed_lines = self._analyze_lines(lines)
        
        # Identify logical boundaries
        boundaries = self._identify_logical_boundaries(analyzed_lines)
        
        # Create chunks based on boundaries
        chunks = self._create_chunks_from_boundaries(analyzed_lines, boundaries)
        
        # Analyze chunk dependencies
        self._analyze_chunk_dependencies(chunks)
        
        return chunks
    
    def _analyze_lines(self, lines: List[str]) -> List[Dict[str, Any]]:
        """Analyze each line for SQL patterns and structure"""
        analyzed = []
        
        for i, line in enumerate(lines, 1):
            clean_line = line.strip()
            line_upper = clean_line.upper()
            
            analysis = {
                'line_number': i,
                'original': line,
                'clean': clean_line,
                'upper': line_upper,
                'is_empty': len(clean_line) == 0,
                'is_comment': clean_line.startswith('--') or clean_line.startswith('/*'),
                'sql_operations': [],
                'control_structures': [],
                'transaction_operations': [],
                'declarations': [],
                'complexity': 0,
                'nesting_change': 0  # +1 for BEGIN/IF, -1 for END
            }
            
            if not analysis['is_empty'] and not analysis['is_comment']:
                # Identify SQL operations
                for keyword in self.sql_keywords:
                    if re.search(rf'\b{keyword}\b', line_upper):
                        analysis['sql_operations'].append(keyword)
                        analysis['complexity'] += 1
                
                # Identify control structures
                for keyword in self.control_keywords:
                    if re.search(rf'\b{keyword}\b', line_upper):
                        analysis['control_structures'].append(keyword)
                        if keyword in ['BEGIN', 'IF', 'WHILE', 'TRY', 'CASE']:
                            analysis['nesting_change'] += 1
                            analysis['complexity'] += 2
                        elif keyword in ['END', 'END IF', 'END WHILE']:
                            analysis['nesting_change'] -= 1
                
                # Additional control flow pattern detection for chunking
                control_flow_starts = [
                    r'\bIF\s+.*\s+BEGIN\b',           # IF condition BEGIN
                    r'\bELSE\s+BEGIN\b',              # ELSE BEGIN  
                    r'\bELSE\s+IF\s+.*\s+BEGIN\b',    # ELSE IF condition BEGIN
                    r'\bWHILE\s+.*\s+BEGIN\b',        # WHILE condition BEGIN
                    r'\bBEGIN\s+TRY\b',               # BEGIN TRY
                    r'\bBEGIN\s+CATCH\b',             # BEGIN CATCH
                ]
                
                for pattern in control_flow_starts:
                    if re.search(pattern, line_upper):
                        analysis['control_structures'].append('CONTROL_FLOW_START')
                        break
                
                # Identify transaction operations
                for keyword in self.transaction_keywords:
                    if keyword in line_upper:
                        analysis['transaction_operations'].append(keyword)
                        analysis['complexity'] += 2
                
                # Identify variable declarations
                var_decl = re.findall(r'DECLARE\s+(@\w+|\w+)', line_upper)
                analysis['declarations'].extend(var_decl)
                
                # Additional complexity factors
                if re.search(r'CURSOR\s+FOR', line_upper):
                    analysis['complexity'] += 3
                if re.search(r'EXEC\s*\(|EXECUTE\s*\(', line_upper):  # Dynamic SQL
                    analysis['complexity'] += 3
                if '@@' in line:  # System variables
                    analysis['complexity'] += 1
                if re.search(r'RAISERROR|THROW', line_upper):
                    analysis['complexity'] += 2
            
            analyzed.append(analysis)
        
        return analyzed
    
    def _identify_logical_boundaries(self, analyzed_lines: List[Dict]) -> List[int]:
        """Identify where logical chunks should begin/end based on complete code blocks"""
        boundaries = [0]  # Always start with first line
        
        # First, find all meaningful control structures and their boundaries
        block_stack = []  # Track nested blocks
        i = 0
        
        while i < len(analyzed_lines):
            line_analysis = analyzed_lines[i]
            line_upper = line_analysis['upper']
            
            # Skip empty lines and comments when looking for boundaries
            if line_analysis['is_empty'] or line_analysis['is_comment']:
                i += 1
                continue
            
            # Look for IF statements
            if re.search(r'\bIF\s+.*(?:BEGIN|$)', line_upper):
                # Find where this IF block ends
                end_line = self._find_if_block_end(analyzed_lines, i)
                if end_line is not None and end_line - i >= self.min_chunk_size:
                    # Create a chunk for this IF block
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if end_line + 1 < len(analyzed_lines) and boundaries[-1] != end_line + 1:
                        boundaries.append(end_line + 1)
                    i = end_line + 1
                    continue
            
            # Look for WHILE loops
            elif re.search(r'\bWHILE\s+.*(?:BEGIN|$)', line_upper):
                end_line = self._find_while_block_end(analyzed_lines, i)
                if end_line is not None and end_line - i >= self.min_chunk_size:
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if end_line + 1 < len(analyzed_lines) and boundaries[-1] != end_line + 1:
                        boundaries.append(end_line + 1)
                    i = end_line + 1
                    continue
            
            # Look for TRY-CATCH blocks (but not if we're in the middle of declarations)
            elif re.search(r'\bBEGIN\s+TRY\b', line_upper):
                # Make sure we're not splitting declarations
                prev_boundary = boundaries[-1] if boundaries else 0
                declaration_section = self._is_in_declaration_section(analyzed_lines, prev_boundary, i)
                
                if not declaration_section:
                    end_line = self._find_try_catch_block_end(analyzed_lines, i)
                    if end_line is not None and end_line - i >= self.min_chunk_size:
                        if i > 0 and boundaries[-1] != i:
                            boundaries.append(i)
                        if end_line + 1 < len(analyzed_lines) and boundaries[-1] != end_line + 1:
                            boundaries.append(end_line + 1)
                        i = end_line + 1
                        continue
            
            # Look for major SQL statement blocks
            elif (line_analysis['sql_operations'] and 
                  any(op in ['INSERT', 'UPDATE', 'DELETE'] for op in line_analysis['sql_operations'])):
                
                # Find the end of this SQL statement
                stmt_end = self._find_sql_statement_end(analyzed_lines, i)
                if stmt_end is not None and stmt_end > i:
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if stmt_end + 1 < len(analyzed_lines) and boundaries[-1] != stmt_end + 1:
                        boundaries.append(stmt_end + 1)
                    i = stmt_end + 1
                    continue
            
            # Look for variable declaration blocks
            elif line_analysis['declarations']:
                # Find the end of the declaration block
                decl_end = self._find_declaration_block_end(analyzed_lines, i)
                if decl_end is not None and decl_end > i:
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if decl_end + 1 < len(analyzed_lines) and boundaries[-1] != decl_end + 1:
                        boundaries.append(decl_end + 1)
                    i = decl_end + 1
                    continue
            
            # Handle section comments as boundaries
            elif (line_analysis['is_comment'] and 
                  len(line_analysis['clean']) > 20 and
                  i - boundaries[-1] >= self.min_chunk_size):
                boundaries.append(i)
            
            i += 1
        
        # Ensure we end with the last line
        if boundaries[-1] != len(analyzed_lines):
            boundaries.append(len(analyzed_lines))
        
        # Clean up boundaries
        cleaned_boundaries = self._clean_boundaries(boundaries, analyzed_lines)
        
        return cleaned_boundaries
    
    def _find_if_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find the end of an IF block"""
        nesting_level = 0
        found_begin = False
        
        for i in range(start_line, len(analyzed_lines)):
            line_upper = analyzed_lines[i]['upper']
            
            # Look for BEGIN
            if 'BEGIN' in line_upper:
                found_begin = True
                nesting_level += 1
            
            # Look for END
            elif re.search(r'\bEND\b', line_upper) and found_begin:
                nesting_level -= 1
                if nesting_level == 0:
                    return i
            
            # Look for ELSE at the same level
            elif (re.search(r'\bELSE\b', line_upper) and nesting_level == 1 and found_begin):
                # Continue to find the end of the ELSE block
                continue
        
        return None
    
    def _find_while_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find the end of a WHILE block"""
        nesting_level = 0
        found_begin = False
        
        for i in range(start_line, len(analyzed_lines)):
            line_upper = analyzed_lines[i]['upper']
            
            if 'BEGIN' in line_upper:
                found_begin = True
                nesting_level += 1
            elif re.search(r'\bEND\b', line_upper) and found_begin:
                nesting_level -= 1
                if nesting_level == 0:
                    return i
        
        return None
    
    def _find_try_catch_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find the end of a TRY-CATCH block"""
        nesting_level = 1  # Start with TRY
        found_catch = False
        
        for i in range(start_line + 1, len(analyzed_lines)):
            line_upper = analyzed_lines[i]['upper']
            
            if re.search(r'\bBEGIN\s+CATCH\b', line_upper):
                found_catch = True
                continue
            elif 'BEGIN' in line_upper:
                nesting_level += 1
            elif re.search(r'\bEND\s+CATCH\b', line_upper):
                return i
            elif re.search(r'\bEND\b', line_upper):
                nesting_level -= 1
                if nesting_level == 0 and found_catch:
                    return i
        
        return None
    
    def _find_sql_statement_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find the end of a SQL statement"""
        for i in range(start_line, min(start_line + 30, len(analyzed_lines))):
            line = analyzed_lines[i]['clean']
            
            # End on semicolon
            if line.endswith(';'):
                return i
            
            # Stop at control flow or other major operations
            if (i > start_line and 
                (analyzed_lines[i]['control_structures'] or
                 (analyzed_lines[i]['sql_operations'] and 
                  any(op in ['INSERT', 'UPDATE', 'DELETE', 'SELECT'] for op in analyzed_lines[i]['sql_operations'])))):
                return i - 1
        
        return start_line + 10  # Default reasonable size
    
    def _find_declaration_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find the end of a variable declaration block, including complete table declarations"""
        in_table_declaration = False
        paren_depth = 0
        
        for i in range(start_line, min(start_line + 100, len(analyzed_lines))):
            line_analysis = analyzed_lines[i]
            line_clean = line_analysis['clean']
            line_upper = line_analysis['upper']
            
            # Skip empty lines and comments within declaration blocks
            if line_analysis['is_empty'] or line_analysis['is_comment']:
                continue
            
            # Check if we're starting a table declaration
            if re.search(r'DECLARE\s+@\w+\s+TABLE\s*\(', line_upper):
                in_table_declaration = True
                paren_depth = line_clean.count('(') - line_clean.count(')')
                continue
            
            # If we're in a table declaration, track parentheses
            if in_table_declaration:
                paren_depth += line_clean.count('(') - line_clean.count(')')
                
                # Table declaration ends when parentheses are balanced
                if paren_depth <= 0:
                    in_table_declaration = False
                    # Check if there's a semicolon on this line or next few lines
                    end_line = i
                    for j in range(i, min(i + 3, len(analyzed_lines))):
                        if ';' in analyzed_lines[j]['clean']:
                            end_line = j
                            break
                    
                    # Continue to see if there are more declarations immediately following
                    next_non_empty = self._find_next_non_empty_line(analyzed_lines, end_line + 1)
                    if (next_non_empty is not None and 
                        analyzed_lines[next_non_empty]['declarations']):
                        continue  # More declarations follow
                    else:
                        return end_line
                continue
            
            # Check for regular declarations
            if line_analysis['declarations']:
                continue
            
            # Check for continuation patterns
            if re.search(r'^\s*[,;)]', line_clean):
                continue
            
            # Check for assignment to declared variables
            if re.search(r'^\s*SET\s+@\w+', line_upper):
                continue
            
            # If we hit non-declaration code and we're not in a table declaration
            if not in_table_declaration:
                return max(i - 1, start_line)
        
        return start_line + 30  # Default reasonable size
    
    def _find_next_non_empty_line(self, analyzed_lines: List[Dict], start: int) -> Optional[int]:
        """Find the next non-empty, non-comment line"""
        for i in range(start, len(analyzed_lines)):
            if not analyzed_lines[i]['is_empty'] and not analyzed_lines[i]['is_comment']:
                return i
        return None
    
    def _is_in_declaration_section(self, analyzed_lines: List[Dict], start: int, end: int) -> bool:
        """Check if the range from start to end is primarily declarations"""
        if end <= start:
            return False
        
        declaration_lines = 0
        total_non_empty_lines = 0
        in_table_declaration = False
        
        for i in range(start, min(end, len(analyzed_lines))):
            line_analysis = analyzed_lines[i]
            
            if line_analysis['is_empty'] or line_analysis['is_comment']:
                continue
            
            total_non_empty_lines += 1
            
            # Check for table declarations
            if re.search(r'DECLARE\s+@\w+\s+TABLE\s*\(', line_analysis['upper']):
                in_table_declaration = True
                declaration_lines += 1
                continue
            
            # If in table declaration, count until we see the closing
            if in_table_declaration:
                declaration_lines += 1
                if ')' in line_analysis['clean'] and line_analysis['clean'].count(')') >= line_analysis['clean'].count('('):
                    in_table_declaration = False
                continue
            
            # Regular declarations
            if line_analysis['declarations']:
                declaration_lines += 1
                continue
            
            # SET statements for variable initialization
            if re.search(r'^\s*SET\s+@\w+', line_analysis['upper']):
                declaration_lines += 1
                continue
        
        # Consider it a declaration section if > 70% of lines are declarations
        return total_non_empty_lines > 0 and (declaration_lines / total_non_empty_lines) > 0.7
    
    def _clean_boundaries(self, boundaries: List[int], analyzed_lines: List[Dict]) -> List[int]:
        """Clean up boundaries to ensure reasonable chunk sizes"""
        cleaned = [0]  # Always start with 0
        
        for i in range(1, len(boundaries)):
            prev_boundary = cleaned[-1]
            current_boundary = boundaries[i]
            chunk_size = current_boundary - prev_boundary
            
            # If chunk is too small, try to merge with next chunk
            if chunk_size < self.min_chunk_size and i < len(boundaries) - 1:
                next_boundary = boundaries[i + 1]
                combined_size = next_boundary - prev_boundary
                
                # Only merge if combined size isn't too large
                if combined_size <= self.max_chunk_size:
                    continue  # Skip this boundary to merge chunks
            
            cleaned.append(current_boundary)
        
        return cleaned
    
    def _create_chunks_from_boundaries(self, analyzed_lines: List[Dict], boundaries: List[int]) -> List[CodeChunk]:
        """Create chunks based on identified boundaries"""
        chunks = []
        
        for i in range(len(boundaries) - 1):
            start_idx = boundaries[i]
            end_idx = boundaries[i + 1]
            
            chunk_lines = analyzed_lines[start_idx:end_idx + 1]
            chunk = self._create_chunk(chunk_lines, i + 1, start_idx + 1)
            chunks.append(chunk)
        
        return chunks
    
    def _create_chunk(self, chunk_lines: List[Dict], chunk_id: int, start_line: int) -> CodeChunk:
        """Create a single chunk with comprehensive analysis"""
        
        # Extract all information from the chunk
        lines = [line['original'] for line in chunk_lines]
        sql_operations = []
        control_structures = []
        variables_declared = []
        variables_used = []
        tables_accessed = []
        total_complexity = 0
        
        for line_data in chunk_lines:
            sql_operations.extend(line_data['sql_operations'])
            control_structures.extend(line_data['control_structures'])
            variables_declared.extend(line_data['declarations'])
            total_complexity += line_data['complexity']
            
            # Extract variables used (not just declared)
            if not line_data['is_comment'] and not line_data['is_empty']:
                vars_in_line = re.findall(r'@\w+', line_data['original'])
                variables_used.extend(vars_in_line)
                
                # Extract table references
                tables_in_line = self._extract_table_references(line_data['original'])
                tables_accessed.extend(tables_in_line)
        
        # Remove duplicates
        sql_operations = list(set(sql_operations))
        control_structures = list(set(control_structures))
        variables_declared = list(set(variables_declared))
        variables_used = list(set(variables_used))
        tables_accessed = list(set(tables_accessed))
        
        # Determine chunk type
        chunk_type = self._determine_chunk_type(sql_operations, control_structures, variables_declared, lines)
        
        # Generate title
        title = self._generate_chunk_title(chunk_type, sql_operations, control_structures, chunk_id)
        
        return CodeChunk(
            chunk_id=chunk_id,
            title=title,
            lines=lines,
            start_line=start_line,
            end_line=start_line + len(lines) - 1,
            chunk_type=chunk_type,
            complexity_score=total_complexity,
            sql_operations=sql_operations,
            variables_declared=variables_declared,
            variables_used=variables_used,
            tables_accessed=tables_accessed,
            control_structures=control_structures,
            dependencies=[]
        )
    
    def _extract_table_references(self, line: str) -> List[str]:
        """Extract table/view references from SQL line"""
        tables = []
        line_upper = line.upper()
        
        # Standard table reference patterns
        patterns = [
            r'FROM\s+([a-zA-Z_][a-zA-Z0-9_]*)',
            r'JOIN\s+([a-zA-Z_][a-zA-Z0-9_]*)',
            r'UPDATE\s+([a-zA-Z_][a-zA-Z0-9_]*)',
            r'INSERT\s+INTO\s+([a-zA-Z_][a-zA-Z0-9_]*)',
            r'DELETE\s+FROM\s+([a-zA-Z_][a-zA-Z0-9_]*)',
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, line_upper)
            tables.extend(matches)
        
        return [t for t in tables if not t.startswith('@')]  # Exclude variables
    
    def _determine_chunk_type(self, sql_ops: List[str], control_structs: List[str], 
                            declarations: List[str], lines: List[str]) -> ChunkType:
        """Determine chunk type based on SQL patterns"""
        
        # Check for declarations
        if declarations:
            return ChunkType.DECLARATION
        
        # Check for transaction control
        if any('TRANSACTION' in ' '.join(lines).upper() or 
               op in ['COMMIT', 'ROLLBACK'] for op in sql_ops):
            return ChunkType.TRANSACTION
        
        # Check for error handling
        if any(ctrl in ['TRY', 'CATCH'] for ctrl in control_structs):
            return ChunkType.ERROR_HANDLING
        
        # Check for loops
        if any(ctrl in ['WHILE', 'FOR'] for ctrl in control_structs):
            return ChunkType.LOOP
        
        # Check for conditionals
        if any(ctrl in ['IF', 'CASE', 'WHEN'] for ctrl in control_structs):
            return ChunkType.CONDITIONAL
        
        # Check for cursor operations
        if 'CURSOR' in ' '.join(lines).upper():
            return ChunkType.CURSOR_OPERATION
        
        # Check for dynamic SQL
        if any(re.search(r'EXEC\s*\(|EXECUTE\s*\(|sp_executesql', line, re.IGNORECASE) for line in lines):
            return ChunkType.DYNAMIC_SQL
        
        # Check for data modification
        if any(op in ['INSERT', 'UPDATE', 'DELETE', 'MERGE'] for op in sql_ops):
            return ChunkType.DATA_MODIFICATION
        
        # Check for data retrieval
        if 'SELECT' in sql_ops:
            return ChunkType.DATA_RETRIEVAL
        
        # Check for calculations (mathematical operations)
        if any(re.search(r'[+\-*/]=|SUM\s*\(|COUNT\s*\(|AVG\s*\(|CASE\s+WHEN', line, re.IGNORECASE) for line in lines):
            return ChunkType.CALCULATION
        
        # Check for validation patterns
        if any(re.search(r'IS\s+NULL|EXISTS\s*\(|<=|>=|<>|!=', line, re.IGNORECASE) for line in lines):
            return ChunkType.VALIDATION
        
        return ChunkType.GENERAL
    
    def _generate_chunk_title(self, chunk_type: ChunkType, sql_ops: List[str], 
                            control_structs: List[str], chunk_id: int) -> str:
        """Generate descriptive title for chunk"""
        
        type_titles = {
            ChunkType.DECLARATION: "Variable & Parameter Declarations",
            ChunkType.VALIDATION: "Data Validation & Checks",
            ChunkType.CONDITIONAL: "Conditional Logic & Branching",
            ChunkType.LOOP: "Loop Processing & Iteration",
            ChunkType.DATA_RETRIEVAL: "Data Query & Retrieval",
            ChunkType.DATA_MODIFICATION: "Data Insert/Update/Delete",
            ChunkType.CALCULATION: "Calculations & Computations",
            ChunkType.TRANSACTION: "Transaction Control",
            ChunkType.ERROR_HANDLING: "Error Handling & Exception Management",
            ChunkType.CURSOR_OPERATION: "Cursor Operations & Row Processing",
            ChunkType.DYNAMIC_SQL: "Dynamic SQL Execution",
            ChunkType.GENERAL: "General Business Logic"
        }
        
        base_title = type_titles.get(chunk_type, "General Logic")
        
        # Add specific operation details
        if sql_ops:
            op_detail = "/".join(sql_ops[:2])  # Show first 2 operations
            return f"{base_title} ({op_detail})"
        elif control_structs:
            ctrl_detail = "/".join(control_structs[:2])
            return f"{base_title} ({ctrl_detail})"
        
        return f"{base_title} - Part {chunk_id}"
    
    def _analyze_chunk_dependencies(self, chunks: List[CodeChunk]):
        """Analyze dependencies between chunks based on variable flow"""
        for i, chunk in enumerate(chunks):
            dependencies = []
            
            for j, prev_chunk in enumerate(chunks[:i]):
                # Check if current chunk uses variables declared in previous chunks
                if any(var in chunk.variables_used for var in prev_chunk.variables_declared):
                    dependencies.append(prev_chunk.chunk_id)
                
                # Check for table dependencies (simple heuristic)
                if (any(table in prev_chunk.tables_accessed for table in chunk.tables_accessed) and
                    'INSERT' in prev_chunk.sql_operations or 'UPDATE' in prev_chunk.sql_operations):
                    if prev_chunk.chunk_id not in dependencies:
                        dependencies.append(prev_chunk.chunk_id)
            
            chunk.dependencies = dependencies

def generate_universal_analysis_guide(chunks: List[CodeChunk]) -> str:
    """Generate universal analysis guide for any stored procedure"""
    guide = []
    
    guide.append("# Universal Stored Procedure Analysis Guide")
    guide.append("=" * 60)
    guide.append("")
    guide.append("## Overview")
    guide.append(f"This stored procedure has been automatically broken into {len(chunks)} logical chunks.")
    guide.append("Each chunk represents a distinct logical operation or set of related operations.")
    guide.append("Analyze each chunk independently to understand the complete business logic.")
    guide.append("")
    
    # Statistics
    chunk_types = {}
    total_complexity = 0
    for chunk in chunks:
        chunk_types[chunk.chunk_type.value] = chunk_types.get(chunk.chunk_type.value, 0) + 1
        total_complexity += chunk.complexity_score
    
    guide.append("## Procedure Statistics")
    guide.append(f"- **Total Chunks**: {len(chunks)}")
    guide.append(f"- **Total Complexity Score**: {total_complexity}")
    guide.append(f"- **Average Complexity per Chunk**: {total_complexity / len(chunks):.1f}")
    guide.append("")
    guide.append("**Chunk Type Distribution:**")
    for chunk_type, count in sorted(chunk_types.items()):
        guide.append(f"- {chunk_type.replace('_', ' ').title()}: {count}")
    guide.append("")
    
    # Analysis order
    guide.append("## Recommended Analysis Order")
    guide.append("Process chunks in this order to maintain logical flow:")
    guide.append("")
    
    # Sort by dependencies first, then by chunk ID
    ordered_chunks = sorted(chunks, key=lambda x: (len(x.dependencies), x.chunk_id))
    
    for i, chunk in enumerate(ordered_chunks, 1):
        guide.append(f"{i}. **Chunk {chunk.chunk_id}**: {chunk.title}")
        guide.append(f"   - Type: {chunk.chunk_type.value}")
        guide.append(f"   - Complexity: {chunk.complexity_score}")
        guide.append(f"   - Lines: {chunk.start_line}-{chunk.end_line}")
        if chunk.dependencies:
            guide.append(f"   - Depends on Chunks: {', '.join(map(str, chunk.dependencies))}")
        guide.append("")
    
    # Detailed chunk analysis
    guide.append("## Detailed Chunk Analysis")
    guide.append("")
    
    for chunk in chunks:
        guide.append(f"### Chunk {chunk.chunk_id}: {chunk.title}")
        guide.append(f"**Type**: {chunk.chunk_type.value}")
        guide.append(f"**Complexity Score**: {chunk.complexity_score}/10")
        guide.append(f"**Lines**: {chunk.start_line}-{chunk.end_line}")
        
        if chunk.sql_operations:
            guide.append(f"**SQL Operations**: {', '.join(chunk.sql_operations)}")
        
        if chunk.control_structures:
            guide.append(f"**Control Structures**: {', '.join(chunk.control_structures)}")
        
        if chunk.variables_declared:
            guide.append(f"**Variables Declared**: {', '.join(chunk.variables_declared)}")
        
        if chunk.variables_used:
            guide.append(f"**Variables Used**: {', '.join(set(chunk.variables_used))}")
        
        if chunk.tables_accessed:
            guide.append(f"**Tables/Views**: {', '.join(chunk.tables_accessed)}")
        
        if chunk.dependencies:
            guide.append(f"**Dependencies**: Chunks {', '.join(map(str, chunk.dependencies))}")
        
        guide.append("")
        guide.append("**Code:**")
        guide.append("```sql")
        for line in chunk.lines:
            guide.append(line)
        guide.append("```")
        guide.append("")
        guide.append("**Universal Analysis Questions:**")
        guide.append("1. What is the primary purpose of this code section?")
        guide.append("2. What business rules or logic constraints are implemented?")
        guide.append("3. What data transformations or validations occur?")
        guide.append("4. What are the inputs and outputs of this section?")
        guide.append("5. What error conditions could occur here?")
        guide.append("6. How does this section fit into the overall procedure flow?")
        guide.append("")
        guide.append("---")
        guide.append("")
    
    return "\n".join(guide)

def main():
    """Main function for command line usage"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Universal SQL stored procedure chunking analyzer')
    parser.add_argument('sql_file', help='Path to SQL file to analyze')
    parser.add_argument('--max-chunk-size', type=int, default=50, help='Maximum lines per chunk')
    parser.add_argument('--min-chunk-size', type=int, default=5, help='Minimum lines per chunk')
    parser.add_argument('--output', '-o', help='Output file for analysis guide')
    parser.add_argument('--format', choices=['markdown', 'json'], default='markdown', help='Output format')
    
    args = parser.parse_args()
    
    # Read SQL file
    with open(args.sql_file, 'r', encoding='utf-8', errors='ignore') as f:
        sql_content = f.read()
    
    # Create analyzer and chunk the procedure
    analyzer = UniversalSQLAnalyzer(
        max_chunk_size=args.max_chunk_size,
        min_chunk_size=args.min_chunk_size
    )
    chunks = analyzer.chunk_procedure(sql_content)
    
    # Generate output
    if args.format == 'json':
        # Convert chunks to serializable format
        chunks_data = []
        for chunk in chunks:
            chunks_data.append({
                'chunk_id': chunk.chunk_id,
                'title': chunk.title,
                'lines': chunk.lines,
                'start_line': chunk.start_line,
                'end_line': chunk.end_line,
                'chunk_type': chunk.chunk_type.value,
                'complexity_score': chunk.complexity_score,
                'sql_operations': chunk.sql_operations,
                'variables_declared': chunk.variables_declared,
                'variables_used': chunk.variables_used,
                'tables_accessed': chunk.tables_accessed,
                'control_structures': chunk.control_structures,
                'dependencies': chunk.dependencies
            })
        output = json.dumps(chunks_data, indent=2)
    else:
        output = generate_universal_analysis_guide(chunks)
    
    # Write output
    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(output)
        print(f"Universal analysis guide written to {args.output}")
        print(f"Created {len(chunks)} chunks for analysis")
        print(f"Total complexity score: {sum(chunk.complexity_score for chunk in chunks)}")
    else:
        print(output)

if __name__ == "__main__":
    main() 