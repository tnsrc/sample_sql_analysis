#!/usr/bin/env python3
"""
Adaptive SQL Stored Procedure Chunked Analyzer
Implements hybrid approach: complete logical blocks when possible, intelligent subdivision when necessary.
Ensures sequential chunking for complete start-to-finish analysis.
"""

import re
from typing import List, Dict, Any, Tuple, Optional, Set
from dataclasses import dataclass
import json
from enum import Enum

class ChunkType(Enum):
    """Generic chunk types based on SQL patterns"""
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

class ChunkStrategy(Enum):
    """Chunking strategies"""
    STRICT_LOGICAL = "strict_logical"      # Complete blocks regardless of size
    SIZE_CONSTRAINED = "size_constrained"  # Break large blocks with context
    FUNCTIONAL = "functional"              # Group by business purpose
    HYBRID = "hybrid"                      # Smart combination

@dataclass
class SubChunkInfo:
    """Information about sub-chunks within a larger logical block"""
    parent_block_type: str
    parent_block_start: int
    parent_block_end: int
    sub_chunk_index: int
    total_sub_chunks: int
    subdivision_reason: str

@dataclass
class CodeChunk:
    """Enhanced code chunk with context and subdivision info"""
    chunk_id: int
    title: str
    lines: List[str]
    start_line: int
    end_line: int
    chunk_type: ChunkType
    complexity_score: int
    sql_operations: List[str]
    variables_declared: List[str]
    variables_used: List[str]
    tables_accessed: List[str]
    control_structures: List[str]
    dependencies: List[int]
    context_summary: str = ""
    sub_chunk_info: Optional[SubChunkInfo] = None
    continuation_from: Optional[int] = None  # Previous chunk ID if subdivided
    continuation_to: Optional[int] = None    # Next chunk ID if subdivided
    business_functions: List[str] = None     # Business functions performed

class AdaptiveSQLAnalyzer:
    def __init__(self, 
                 strategy: ChunkStrategy = ChunkStrategy.HYBRID,
                 target_chunk_size: int = 60,
                 min_chunk_size: int = 10,
                 max_chunk_size: int = 120,
                 force_subdivision_threshold: int = 200):
        
        self.strategy = strategy
        self.target_chunk_size = target_chunk_size
        self.min_chunk_size = min_chunk_size  
        self.max_chunk_size = max_chunk_size
        self.force_subdivision_threshold = force_subdivision_threshold
        self.chunks = []
        
        # SQL pattern recognition
        self.sql_keywords = {
            'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'MERGE', 'EXEC', 'EXECUTE',
            'CREATE', 'ALTER', 'DROP', 'TRUNCATE', 'BULK'
        }
        
        # Stored procedure and function call patterns
        self.proc_function_patterns = {
            'STORED_PROCEDURES': [
                r'EXEC(?:UTE)?\s+([a-zA-Z_][a-zA-Z0-9_]*\.?[a-zA-Z_][a-zA-Z0-9_]*)',  # EXEC sp_name
                r'EXEC(?:UTE)?\s+(\[?[a-zA-Z_][a-zA-Z0-9_]*\]?\.\[?[a-zA-Z_][a-zA-Z0-9_]*\]?)',  # EXEC [schema].[sp_name]
                r'EXEC(?:UTE)?\s*\(\s*([^)]+)\s*\)',  # EXEC dynamic SQL
                r'(sp_executesql)',  # Dynamic SQL execution
                r'EXEC(?:UTE)?\s+(sp_[a-zA-Z_][a-zA-Z0-9_]*)',  # EXEC sp_procedurename
                r'EXEC(?:UTE)?\s+(usp_[a-zA-Z_][a-zA-Z0-9_]*)',  # EXEC usp_procedurename
                r'EXEC(?:UTE)?\s+(proc_[a-zA-Z_][a-zA-Z0-9_]*)',  # EXEC proc_procedurename
                r'CALL\s+([a-zA-Z_][a-zA-Z0-9_]*\.?[a-zA-Z_][a-zA-Z0-9_]*)',  # CALL procedure (MySQL/PostgreSQL style)
            ],
            'SYSTEM_FUNCTIONS': [
                r'(GETDATE|GETUTCDATE|SYSDATETIME|CURRENT_TIMESTAMP)\s*\(?',
                r'(NEWID|NEWSEQUENTIALID)\s*\(',
                r'(SCOPE_IDENTITY|@@IDENTITY|@@ROWCOUNT|@@ERROR|@@TRANCOUNT)\b',
                r'(USER_NAME|SUSER_NAME|SYSTEM_USER|ORIGINAL_LOGIN)\s*\(?',
            ],
            'AGGREGATE_FUNCTIONS': [
                r'(SUM|COUNT|MAX|MIN|AVG|STDEV|VAR|VARP|STDEVP)\s*\(',
                r'(COUNT_BIG|GROUPING|GROUPING_ID)\s*\(',
            ],
            'STRING_FUNCTIONS': [
                r'(LEN|DATALENGTH|SUBSTRING|LEFT|RIGHT|CHARINDEX|PATINDEX)\s*\(',
                r'(REPLACE|STUFF|REVERSE|UPPER|LOWER|LTRIM|RTRIM|TRIM)\s*\(',
                r'(CONCAT|FORMAT|STRING_AGG|STRING_SPLIT)\s*\(',
            ],
            'DATE_FUNCTIONS': [
                r'(DATEADD|DATEDIFF|DATEDIFF_BIG|DATEPART|DATENAME)\s*\(',
                r'(YEAR|MONTH|DAY|DATETRUNC|EOMONTH|ISDATE)\s*\(',
            ],
            'MATH_FUNCTIONS': [
                r'(ABS|CEILING|FLOOR|ROUND|POWER|SQRT|LOG|LOG10|EXP)\s*\(',
                r'(SIN|COS|TAN|ASIN|ACOS|ATAN|ATN2|DEGREES|RADIANS)\s*\(',
                r'(RAND|SIGN|PI)\s*\(?',
            ],
            'CONVERSION_FUNCTIONS': [
                r'(CAST|CONVERT|TRY_CAST|TRY_CONVERT|PARSE|TRY_PARSE)\s*\(',
                r'(ISNULL|COALESCE|NULLIF|IIF|CHOOSE)\s*\(',
            ],
            'WINDOW_FUNCTIONS': [
                r'(ROW_NUMBER|RANK|DENSE_RANK|NTILE)\s*\(',
                r'(LAG|LEAD|FIRST_VALUE|LAST_VALUE)\s*\(',
                r'(CUME_DIST|PERCENT_RANK|PERCENTILE_CONT|PERCENTILE_DISC)\s*\(',
            ],
            'LOGICAL_FUNCTIONS': [
                r'(EXISTS|NOT\s+EXISTS)\s*\(',
                r'(CASE\s+WHEN|IIF)\s*\(',
            ],
            'USER_DEFINED': [
                r'([a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*)\s*\(',  # schema.function_name()
                r'(dbo\.[a-zA-Z_][a-zA-Z0-9_]*)\s*\(',  # dbo.function_name()
                r'(\[dbo\]\.\[[a-zA-Z_][a-zA-Z0-9_]*\])\s*\(',  # [dbo].[function_name]()
                r'([a-zA-Z_][a-zA-Z0-9_]*\.\[[a-zA-Z_][a-zA-Z0-9_]*\])\s*\(',  # schema.[function_name]()
                r'(\[[a-zA-Z_][a-zA-Z0-9_]*\]\.\[[a-zA-Z_][a-zA-Z0-9_]*\])\s*\(',  # [schema].[function_name]()
                r'(fn_[a-zA-Z_][a-zA-Z0-9_]*)\s*\(',  # fn_function_name() - common UDF naming
                r'(udf_[a-zA-Z_][a-zA-Z0-9_]*)\s*\(',  # udf_function_name() - common UDF naming
                r'(func_[a-zA-Z_][a-zA-Z0-9_]*)\s*\(',  # func_function_name() - common UDF naming
            ]
        }
        
        self.control_keywords = {
            'IF', 'ELSE', 'WHILE', 'FOR', 'BEGIN', 'END', 'TRY', 'CATCH',
            'GOTO', 'RETURN', 'BREAK', 'CONTINUE', 'CASE', 'WHEN'
        }
        
        self.transaction_keywords = {
            'BEGIN TRANSACTION', 'COMMIT', 'ROLLBACK', 'SAVE TRANSACTION'
        }
        
        # Business function patterns
        self.business_function_patterns = {
            'CUSTOMER_VALIDATION': [r'customer.*valid', r'@customer.*check', r'customer.*exist'],
            'INVENTORY_MANAGEMENT': [r'inventory', r'stock', r'warehouse', r'allocation'],
            'PAYMENT_PROCESSING': [r'payment', r'transaction', r'authorize', r'charge'],
            'TAX_CALCULATION': [r'tax', r'rate.*calculate', r'tax.*amount'],
            'SHIPPING_LOGISTICS': [r'shipping', r'delivery', r'freight', r'carrier'],
            'LOYALTY_REWARDS': [r'loyalty', r'points', r'reward', r'tier'],
            'PROMOTION_DISCOUNT': [r'promo', r'discount', r'coupon', r'offer'],
            'AUDIT_LOGGING': [r'audit', r'log', r'track', r'history'],
            'NOTIFICATION': [r'notification', r'alert', r'email', r'message'],
            'REPORTING': [r'report', r'summary', r'analytics', r'statistics']
        }
    
    def chunk_procedure(self, sql_content: str) -> List[CodeChunk]:
        """Main chunking method implementing adaptive strategy"""
        lines = sql_content.split('\n')
        analyzed_lines = self._analyze_lines(lines)
        
        # Step 1: Identify logical boundaries (complete blocks)
        logical_boundaries = self._identify_logical_boundaries(analyzed_lines)
        
        # Step 2: Create initial logical chunks
        logical_chunks = self._create_chunks_from_boundaries(analyzed_lines, logical_boundaries)
        
        # Step 3: Apply adaptive subdivision based on strategy
        final_chunks = self._apply_adaptive_subdivision(logical_chunks, analyzed_lines)
        
        # Step 4: Add context and cross-references
        self._add_context_and_references(final_chunks)
        
        # Step 5: Analyze dependencies to ensure sequential flow
        self._analyze_chunk_dependencies(final_chunks)
        
        return final_chunks
    
    def _analyze_lines(self, lines: List[str]) -> List[Dict[str, Any]]:
        """Comprehensive line analysis with business function detection"""
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
                'is_section_comment': False,
                'sql_operations': [],
                'control_structures': [],
                'transaction_operations': [],
                'declarations': [],
                'business_functions': [],
                'complexity': 0,
                'nesting_change': 0
            }
            
            if not analysis['is_empty'] and not analysis['is_comment']:
                # Analyze SQL operations
                for keyword in self.sql_keywords:
                    if re.search(rf'\b{keyword}\b', line_upper):
                        analysis['sql_operations'].append(keyword)
                        analysis['complexity'] += 1
                
                # Analyze stored procedure and function calls
                for category, patterns in self.proc_function_patterns.items():
                    for pattern in patterns:
                        matches = re.findall(pattern, line_upper)
                        for match in matches:
                            if isinstance(match, tuple):
                                # For patterns with groups, take the first non-empty group
                                proc_func_name = next((m for m in match if m), match[0] if match else '')
                            else:
                                proc_func_name = match
                            
                            if proc_func_name:
                                # Add categorized operation
                                if category == 'STORED_PROCEDURES':
                                    analysis['sql_operations'].append(f'SP_CALL:{proc_func_name}')
                                    analysis['complexity'] += 2  # SP calls are more complex
                                elif category == 'USER_DEFINED':
                                    analysis['sql_operations'].append(f'UDF_CALL:{proc_func_name}')
                                    analysis['complexity'] += 2  # UDF calls are more complex
                                else:
                                    # System functions, aggregate functions, etc.
                                    func_type = category.replace('_FUNCTIONS', '').replace('_', ' ').title()
                                    analysis['sql_operations'].append(f'{func_type}:{proc_func_name}')
                                    analysis['complexity'] += 1
                
                # Analyze control structures
                for keyword in self.control_keywords:
                    if re.search(rf'\b{keyword}\b', line_upper):
                        analysis['control_structures'].append(keyword)
                        if keyword in ['BEGIN', 'IF', 'WHILE', 'TRY', 'CASE']:
                            analysis['nesting_change'] += 1
                            analysis['complexity'] += 2
                        elif keyword in ['END', 'END IF', 'END WHILE']:
                            analysis['nesting_change'] -= 1
                
                # Analyze business functions
                for func_name, patterns in self.business_function_patterns.items():
                    for pattern in patterns:
                        if re.search(pattern, line_upper):
                            analysis['business_functions'].append(func_name)
                            break
                
                # Identify declarations
                var_decl = re.findall(r'DECLARE\s+(@\w+|\w+)', line_upper)
                analysis['declarations'].extend(var_decl)
                
                # Additional complexity factors
                if re.search(r'CURSOR\s+FOR', line_upper):
                    analysis['complexity'] += 3
                if re.search(r'EXEC\s*\(|EXECUTE\s*\(', line_upper):
                    analysis['complexity'] += 3
                if '@@' in line:
                    analysis['complexity'] += 1
                if re.search(r'RAISERROR|THROW', line_upper):
                    analysis['complexity'] += 2
            
            # Check for section comments (potential subdivision points)
            elif analysis['is_comment'] and len(clean_line) > 20:
                if re.search(r'={3,}|_{3,}|-{3,}', clean_line):
                    analysis['is_section_comment'] = True
            
            analyzed.append(analysis)
        
        return analyzed
    
    def _identify_logical_boundaries(self, analyzed_lines: List[Dict]) -> List[int]:
        """Identify complete logical block boundaries"""
        boundaries = [0]
        i = 0
        
        while i < len(analyzed_lines):
            line_analysis = analyzed_lines[i]
            
            if line_analysis['is_empty'] or line_analysis['is_comment']:
                i += 1
                continue
            
            # Look for complete logical blocks
            if self._is_control_flow_start(line_analysis):
                end_line = self._find_complete_block_end(analyzed_lines, i)
                if end_line is not None:
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if end_line + 1 < len(analyzed_lines):
                        boundaries.append(end_line + 1)
                    i = end_line + 1
                    continue
            
            # Look for declaration blocks
            elif line_analysis['declarations']:
                end_line = self._find_declaration_block_end(analyzed_lines, i)
                if end_line is not None and end_line > i:
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if end_line + 1 < len(analyzed_lines):
                        boundaries.append(end_line + 1)
                    i = end_line + 1
                    continue
            
            # Look for major SQL statements
            elif line_analysis['sql_operations']:
                end_line = self._find_sql_statement_end(analyzed_lines, i)
                if end_line is not None and end_line > i:
                    if i > 0 and boundaries[-1] != i:
                        boundaries.append(i)
                    if end_line + 1 < len(analyzed_lines):
                        boundaries.append(end_line + 1)
                    i = end_line + 1
                    continue
            
            i += 1
        
        if boundaries[-1] != len(analyzed_lines):
            boundaries.append(len(analyzed_lines))
        
        return boundaries
    
    def _is_control_flow_start(self, line_analysis: Dict) -> bool:
        """Check if line starts a control flow block"""
        line_upper = line_analysis['upper']
        return (re.search(r'\bIF\s+.*(?:BEGIN|$)', line_upper) or
                re.search(r'\bWHILE\s+.*(?:BEGIN|$)', line_upper) or
                re.search(r'\bBEGIN\s+TRY\b', line_upper) or
                re.search(r'\bBEGIN\s+CATCH\b', line_upper))
    
    def _find_complete_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find the end of a complete control flow block"""
        line_upper = analyzed_lines[start_line]['upper']
        
        if re.search(r'\bIF\s+.*(?:BEGIN|$)', line_upper):
            return self._find_if_block_end(analyzed_lines, start_line)
        elif re.search(r'\bWHILE\s+.*(?:BEGIN|$)', line_upper):
            return self._find_while_block_end(analyzed_lines, start_line)
        elif re.search(r'\bBEGIN\s+TRY\b', line_upper):
            return self._find_try_catch_block_end(analyzed_lines, start_line)
        
        return None
    
    def _find_if_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find complete IF-ELSE-END block"""
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
    
    def _find_while_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find complete WHILE-END block"""
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
        """Find complete TRY-CATCH-END block"""
        nesting_level = 1
        found_catch = False
        
        for i in range(start_line + 1, len(analyzed_lines)):
            line_upper = analyzed_lines[i]['upper']
            
            if re.search(r'\bBEGIN\s+CATCH\b', line_upper):
                found_catch = True
            elif 'BEGIN' in line_upper:
                nesting_level += 1
            elif re.search(r'\bEND\s+CATCH\b', line_upper):
                return i
            elif re.search(r'\bEND\b', line_upper):
                nesting_level -= 1
                if nesting_level == 0 and found_catch:
                    return i
        
        return None
    
    def _find_declaration_block_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find end of complete declaration block including table declarations"""
        in_table_declaration = False
        paren_depth = 0
        
        for i in range(start_line, min(start_line + 150, len(analyzed_lines))):
            line_analysis = analyzed_lines[i]
            line_clean = line_analysis['clean']
            line_upper = line_analysis['upper']
            
            if line_analysis['is_empty'] or line_analysis['is_comment']:
                continue
            
            if re.search(r'DECLARE\s+@\w+\s+TABLE\s*\(', line_upper):
                in_table_declaration = True
                paren_depth = line_clean.count('(') - line_clean.count(')')
                continue
            
            if in_table_declaration:
                paren_depth += line_clean.count('(') - line_clean.count(')')
                if paren_depth <= 0:
                    in_table_declaration = False
                continue
            
            if (line_analysis['declarations'] or 
                re.search(r'^\s*[,;)]', line_clean) or
                re.search(r'^\s*SET\s+@\w+', line_upper)):
                continue
            
            if not in_table_declaration:
                return max(i - 1, start_line)
        
        return start_line + 50
    
    def _find_sql_statement_end(self, analyzed_lines: List[Dict], start_line: int) -> Optional[int]:
        """Find end of SQL statement"""
        for i in range(start_line, min(start_line + 40, len(analyzed_lines))):
            line = analyzed_lines[i]['clean']
            
            if line.endswith(';'):
                return i
            
            if (i > start_line and 
                (analyzed_lines[i]['control_structures'] or
                 (analyzed_lines[i]['sql_operations'] and 
                  any(op in ['INSERT', 'UPDATE', 'DELETE', 'SELECT'] for op in analyzed_lines[i]['sql_operations'])))):
                return i - 1
        
        return start_line + 15
    
    def _create_chunks_from_boundaries(self, analyzed_lines: List[Dict], boundaries: List[int]) -> List[CodeChunk]:
        """Create initial logical chunks"""
        chunks = []
        
        for i in range(len(boundaries) - 1):
            start_idx = boundaries[i]
            end_idx = boundaries[i + 1] - 1
            
            chunk_lines = analyzed_lines[start_idx:end_idx + 1]
            chunk = self._create_chunk(chunk_lines, i + 1, start_idx + 1)
            chunks.append(chunk)
        
        # Merge comment-only chunks with next chunks
        chunks = self._merge_comment_only_chunks(chunks)
        
        return chunks

    def _merge_comment_only_chunks(self, chunks: List[CodeChunk]) -> List[CodeChunk]:
        """Merge comment-only chunks with the next chunk for better context"""
        if not chunks:
            return chunks
            
        merged_chunks = []
        i = 0
        
        while i < len(chunks):
            current_chunk = chunks[i]
            
            # Check if current chunk is comment-only
            if self._is_comment_only_chunk(current_chunk):
                # Find next non-comment chunk to merge with
                next_chunk_idx = i + 1
                while (next_chunk_idx < len(chunks) and 
                       self._is_comment_only_chunk(chunks[next_chunk_idx])):
                    next_chunk_idx += 1
                
                if next_chunk_idx < len(chunks):
                    # Merge comment chunk(s) with next actual code chunk
                    comment_chunks = chunks[i:next_chunk_idx]
                    next_chunk = chunks[next_chunk_idx]
                    merged_chunk = self._merge_chunks(comment_chunks + [next_chunk])
                    merged_chunks.append(merged_chunk)
                    i = next_chunk_idx + 1
                else:
                    # No more non-comment chunks, keep the comment chunk
                    merged_chunks.append(current_chunk)
                    i += 1
            else:
                merged_chunks.append(current_chunk)
                i += 1
        
        # Reassign sequential chunk IDs
        for idx, chunk in enumerate(merged_chunks):
            chunk.chunk_id = idx + 1
            
        return merged_chunks

    def _is_comment_only_chunk(self, chunk: CodeChunk) -> bool:
        """Check if chunk contains only comments and empty lines"""
        for line in chunk.lines:
            stripped = line.strip()
            if stripped and not (stripped.startswith('--') or 
                               stripped.startswith('/*') or 
                               stripped.startswith('*') or 
                               stripped.endswith('*/')):
                return False
        return True

    def _merge_chunks(self, chunks_to_merge: List[CodeChunk]) -> CodeChunk:
        """Merge multiple chunks into one"""
        if len(chunks_to_merge) == 1:
            return chunks_to_merge[0]
            
        # Use the last (non-comment) chunk as the base
        base_chunk = chunks_to_merge[-1]
        
        # Combine all lines
        all_lines = []
        for chunk in chunks_to_merge:
            all_lines.extend(chunk.lines)
        
        # Combine analysis data from all chunks
        all_sql_operations = []
        all_control_structures = []
        all_variables_declared = []
        all_variables_used = []
        all_tables_accessed = []
        all_business_functions = []
        total_complexity = 0
        
        for chunk in chunks_to_merge:
            all_sql_operations.extend(chunk.sql_operations)
            all_control_structures.extend(chunk.control_structures)
            all_variables_declared.extend(chunk.variables_declared)
            all_variables_used.extend(chunk.variables_used)
            all_tables_accessed.extend(chunk.tables_accessed)
            all_business_functions.extend(chunk.business_functions)
            total_complexity += chunk.complexity_score
        
        # Remove duplicates
        all_sql_operations = list(set(all_sql_operations))
        all_control_structures = list(set(all_control_structures))
        all_variables_declared = list(set(all_variables_declared))
        all_variables_used = list(set(all_variables_used))
        all_tables_accessed = list(set(all_tables_accessed))
        all_business_functions = list(set(all_business_functions))
        
        # Create merged chunk
        merged_chunk = CodeChunk(
            chunk_id=base_chunk.chunk_id,
            title=base_chunk.title,
            lines=all_lines,
            start_line=chunks_to_merge[0].start_line,
            end_line=chunks_to_merge[-1].end_line,
            chunk_type=base_chunk.chunk_type,
            complexity_score=total_complexity,
            sql_operations=all_sql_operations,
            variables_declared=all_variables_declared,
            variables_used=all_variables_used,
            tables_accessed=all_tables_accessed,
            control_structures=all_control_structures,
            dependencies=[],
            business_functions=all_business_functions
        )
        
        return merged_chunk

    def _create_chunk(self, chunk_lines: List[Dict], chunk_id: int, start_line: int) -> CodeChunk:
        """Create a single chunk with comprehensive analysis"""
        lines = [line['original'] for line in chunk_lines]
        sql_operations = []
        control_structures = []
        variables_declared = []
        variables_used = []
        tables_accessed = []
        business_functions = []
        total_complexity = 0
        
        for line_data in chunk_lines:
            sql_operations.extend(line_data['sql_operations'])
            control_structures.extend(line_data['control_structures'])
            variables_declared.extend(line_data['declarations'])
            business_functions.extend(line_data['business_functions'])
            total_complexity += line_data['complexity']
            
            if not line_data['is_comment'] and not line_data['is_empty']:
                vars_in_line = re.findall(r'@\w+', line_data['original'])
                variables_used.extend(vars_in_line)
                tables_in_line = self._extract_table_references(line_data['original'])
                tables_accessed.extend(tables_in_line)
        
        # Remove duplicates
        sql_operations = list(set(sql_operations))
        control_structures = list(set(control_structures))
        variables_declared = list(set(variables_declared))
        variables_used = list(set(variables_used))
        tables_accessed = list(set(tables_accessed))
        business_functions = list(set(business_functions))
        
        chunk_type = self._determine_chunk_type(sql_operations, control_structures, variables_declared, lines)
        title = self._generate_chunk_title(chunk_type, sql_operations, control_structures, business_functions, chunk_id)
        
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
            dependencies=[],
            business_functions=business_functions
        )
    
    def _extract_table_references(self, line: str) -> List[str]:
        """Extract table/view references"""
        tables = []
        line_upper = line.upper()
        
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
        
        return [t for t in tables if not t.startswith('@')]
    
    def _determine_chunk_type(self, sql_ops: List[str], control_structs: List[str], 
                            declarations: List[str], lines: List[str]) -> ChunkType:
        """Determine chunk type based on analysis"""
        if declarations:
            return ChunkType.DECLARATION
        
        if any('TRANSACTION' in ' '.join(lines).upper() or 
               op in ['COMMIT', 'ROLLBACK'] for op in sql_ops):
            return ChunkType.TRANSACTION
        
        if any(ctrl in ['TRY', 'CATCH'] for ctrl in control_structs):
            return ChunkType.ERROR_HANDLING
        
        if any(ctrl in ['WHILE', 'FOR'] for ctrl in control_structs):
            return ChunkType.LOOP
        
        if any(ctrl in ['IF', 'CASE', 'WHEN'] for ctrl in control_structs):
            return ChunkType.CONDITIONAL
        
        if 'CURSOR' in ' '.join(lines).upper():
            return ChunkType.CURSOR_OPERATION
        
        if any(re.search(r'EXEC\s*\(|EXECUTE\s*\(|sp_executesql', line, re.IGNORECASE) for line in lines):
            return ChunkType.DYNAMIC_SQL
        
        if any(op in ['INSERT', 'UPDATE', 'DELETE', 'MERGE'] for op in sql_ops):
            return ChunkType.DATA_MODIFICATION
        
        if 'SELECT' in sql_ops:
            return ChunkType.DATA_RETRIEVAL
        
        if any(re.search(r'[+\-*/]=|SUM\s*\(|COUNT\s*\(|AVG\s*\(|CASE\s+WHEN', line, re.IGNORECASE) for line in lines):
            return ChunkType.CALCULATION
        
        if any(re.search(r'IS\s+NULL|EXISTS\s*\(|<=|>=|<>|!=', line, re.IGNORECASE) for line in lines):
            return ChunkType.VALIDATION
        
        return ChunkType.GENERAL
    
    def _generate_chunk_title(self, chunk_type: ChunkType, sql_ops: List[str], 
                            control_structs: List[str], business_functions: List[str], chunk_id: int) -> str:
        """Generate descriptive title"""
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
        
        # Add business function context if available
        if business_functions:
            func_detail = "/".join(business_functions[:2])
            base_title += f" - {func_detail.replace('_', ' ').title()}"
        elif sql_ops:
            op_detail = "/".join(sql_ops[:2])
            base_title += f" ({op_detail})"
        elif control_structs:
            ctrl_detail = "/".join(control_structs[:2])
            base_title += f" ({ctrl_detail})"
        
        return base_title
    
    def _apply_adaptive_subdivision(self, logical_chunks: List[CodeChunk], analyzed_lines: List[Dict]) -> List[CodeChunk]:
        """Apply adaptive subdivision based on strategy and size"""
        if self.strategy == ChunkStrategy.STRICT_LOGICAL:
            return logical_chunks
        
        final_chunks = []
        
        for chunk in logical_chunks:
            chunk_size = len(chunk.lines)
            
            # Apply subdivision logic based on size and strategy
            if (chunk_size > self.max_chunk_size or 
                (self.strategy == ChunkStrategy.HYBRID and chunk_size > self.force_subdivision_threshold)):
                
                # Subdivide large chunk
                sub_chunks = self._subdivide_large_chunk(chunk, analyzed_lines)
                final_chunks.extend(sub_chunks)
            else:
                final_chunks.append(chunk)
        
        # Reassign sequential chunk IDs
        for i, chunk in enumerate(final_chunks, 1):
            chunk.chunk_id = i
        
        return final_chunks
    
    def _subdivide_large_chunk(self, large_chunk: CodeChunk, analyzed_lines: List[Dict]) -> List[CodeChunk]:
        """Intelligently subdivide a large chunk"""
        chunk_lines = analyzed_lines[large_chunk.start_line - 1:large_chunk.end_line]
        subdivision_points = []
        
        # Look for natural subdivision points
        subdivision_points.extend(self._find_section_comment_subdivisions(chunk_lines))
        subdivision_points.extend(self._find_business_function_subdivisions(chunk_lines))
        subdivision_points.extend(self._find_nested_structure_subdivisions(chunk_lines))
        
        # Sort and clean subdivision points
        subdivision_points = sorted(list(set(subdivision_points)))
        subdivision_points = [0] + subdivision_points + [len(chunk_lines)]
        
        # Create sub-chunks
        sub_chunks = []
        for i in range(len(subdivision_points) - 1):
            start_idx = subdivision_points[i]
            end_idx = subdivision_points[i + 1]
            
            if end_idx - start_idx < self.min_chunk_size:
                continue  # Skip too-small chunks
            
            sub_chunk_lines = chunk_lines[start_idx:end_idx]
            sub_chunk = self._create_chunk(sub_chunk_lines, 0, large_chunk.start_line + start_idx)
            
            # Add subdivision context
            sub_chunk.sub_chunk_info = SubChunkInfo(
                parent_block_type=large_chunk.chunk_type.value,
                parent_block_start=large_chunk.start_line,
                parent_block_end=large_chunk.end_line,
                sub_chunk_index=i + 1,
                total_sub_chunks=len(subdivision_points) - 1,
                subdivision_reason="Size optimization"
            )
            
            # Update title to reflect subdivision
            sub_chunk.title += f" (Part {i + 1})"
            
            sub_chunks.append(sub_chunk)
        
        # Link subdivided chunks for continuity
        for i in range(len(sub_chunks)):
            if i > 0:
                sub_chunks[i].continuation_from = sub_chunks[i-1].chunk_id
            if i < len(sub_chunks) - 1:
                sub_chunks[i].continuation_to = sub_chunks[i+1].chunk_id
        
        return sub_chunks if sub_chunks else [large_chunk]
    
    def _find_section_comment_subdivisions(self, chunk_lines: List[Dict]) -> List[int]:
        """Find subdivision points based on section comments"""
        points = []
        for i, line_data in enumerate(chunk_lines):
            if line_data.get('is_section_comment', False):
                points.append(i)
        return points
    
    def _find_business_function_subdivisions(self, chunk_lines: List[Dict]) -> List[int]:
        """Find subdivision points based on business function changes"""
        points = []
        current_functions = set()
        
        for i, line_data in enumerate(chunk_lines):
            line_functions = set(line_data.get('business_functions', []))
            
            if line_functions and line_functions != current_functions:
                if current_functions:  # Not the first function change
                    points.append(i)
                current_functions = line_functions
        
        return points
    
    def _find_nested_structure_subdivisions(self, chunk_lines: List[Dict]) -> List[int]:
        """Find subdivision points based on nested control structures"""
        points = []
        nesting_level = 0
        
        for i, line_data in enumerate(chunk_lines):
            nesting_change = line_data.get('nesting_change', 0)
            nesting_level += nesting_change
            
            # Add subdivision point when we return to a lower nesting level
            if nesting_change < 0 and nesting_level <= 1:
                points.append(i + 1)
        
        return points
    
    def _add_context_and_references(self, chunks: List[CodeChunk]):
        """Add context summaries and cross-references"""
        for i, chunk in enumerate(chunks):
            # Add context summary
            chunk.context_summary = self._generate_context_summary(chunk, chunks, i)
            
            # Add continuation references for subdivided chunks
            if chunk.sub_chunk_info:
                if chunk.continuation_from:
                    chunk.context_summary = f"[Continues from Chunk {chunk.continuation_from}] " + chunk.context_summary
                if chunk.continuation_to:
                    chunk.context_summary += f" [Continues in Chunk {chunk.continuation_to}]"
    
    def _generate_context_summary(self, chunk: CodeChunk, all_chunks: List[CodeChunk], chunk_index: int) -> str:
        """Generate context summary for a chunk"""
        summary_parts = []
        
        # Business function summary
        if chunk.business_functions:
            summary_parts.append(f"Handles {', '.join(chunk.business_functions).replace('_', ' ').lower()}")
        
        # Operation summary
        if chunk.sql_operations:
            summary_parts.append(f"Performs {', '.join(chunk.sql_operations).lower()} operations")
        
        # Control flow summary
        if chunk.control_structures:
            summary_parts.append(f"Uses {', '.join(chunk.control_structures).lower()} logic")
        
        # Position context
        if chunk_index > 0:
            prev_chunk = all_chunks[chunk_index - 1]
            summary_parts.append(f"Follows {prev_chunk.chunk_type.value.replace('_', ' ')}")
        
        return ". ".join(summary_parts) if summary_parts else "General processing logic"
    
    def _analyze_chunk_dependencies(self, chunks: List[CodeChunk]):
        """Analyze dependencies to ensure sequential flow"""
        for i, chunk in enumerate(chunks):
            dependencies = []
            
            # Check variable dependencies
            for j, prev_chunk in enumerate(chunks[:i]):
                if any(var in chunk.variables_used for var in prev_chunk.variables_declared):
                    dependencies.append(prev_chunk.chunk_id)
            
            # Check continuation dependencies
            if chunk.continuation_from:
                if chunk.continuation_from not in dependencies:
                    dependencies.append(chunk.continuation_from)
            
            chunk.dependencies = dependencies

def generate_adaptive_analysis_guide(chunks: List[CodeChunk], strategy: ChunkStrategy, config: Dict) -> str:
    """Generate comprehensive analysis guide with adaptive chunking details"""
    guide = []
    
    guide.append("# Adaptive SQL Stored Procedure Analysis Guide")
    guide.append("=" * 70)
    guide.append("")
    guide.append(f"**Chunking Strategy**: {strategy.value.replace('_', ' ').title()}")
    guide.append(f"**Target Chunk Size**: {config.get('target_chunk_size', 60)} lines")
    guide.append(f"**Max Chunk Size**: {config.get('max_chunk_size', 120)} lines")
    guide.append("")
    
    # Enhanced statistics
    chunk_types = {}
    total_complexity = 0
    subdivided_chunks = 0
    business_functions = set()
    
    for chunk in chunks:
        chunk_types[chunk.chunk_type.value] = chunk_types.get(chunk.chunk_type.value, 0) + 1
        total_complexity += chunk.complexity_score
        if chunk.sub_chunk_info:
            subdivided_chunks += 1
        business_functions.update(chunk.business_functions)
    
    guide.append("## Procedure Statistics")
    guide.append(f"- **Total Chunks**: {len(chunks)}")
    guide.append(f"- **Subdivided Chunks**: {subdivided_chunks}")
    guide.append(f"- **Total Complexity Score**: {total_complexity}")
    guide.append(f"- **Average Complexity per Chunk**: {total_complexity / len(chunks):.1f}")
    guide.append(f"- **Business Functions Identified**: {len(business_functions)}")
    guide.append("")
    
    if business_functions:
        guide.append("**Business Functions:**")
        for func in sorted(business_functions):
            guide.append(f"- {func.replace('_', ' ').title()}")
        guide.append("")
    
    guide.append("**Chunk Type Distribution:**")
    for chunk_type, count in sorted(chunk_types.items()):
        guide.append(f"- {chunk_type.replace('_', ' ').title()}: {count}")
    guide.append("")
    
    # Sequential analysis order
    guide.append("## Sequential Analysis Order")
    guide.append("Analyze chunks in this exact order for complete understanding:")
    guide.append("")
    
    for i, chunk in enumerate(chunks, 1):
        guide.append(f"{i}. **Chunk {chunk.chunk_id}**: {chunk.title}")
        guide.append(f"   - Type: {chunk.chunk_type.value}")
        guide.append(f"   - Complexity: {chunk.complexity_score}")
        guide.append(f"   - Lines: {chunk.start_line}-{chunk.end_line}")
        guide.append(f"   - Context: {chunk.context_summary}")
        
        if chunk.dependencies:
            guide.append(f"   - Dependencies: Chunks {', '.join(map(str, chunk.dependencies))}")
        
        if chunk.business_functions:
            guide.append(f"   - Business Functions: {', '.join(chunk.business_functions).replace('_', ' ').title()}")
        
        if chunk.sub_chunk_info:
            info = chunk.sub_chunk_info
            guide.append(f"   - Subdivision: Part {info.sub_chunk_index}/{info.total_sub_chunks} of {info.parent_block_type}")
        
        guide.append("")
    
    # Detailed chunk analysis
    guide.append("## Detailed Sequential Analysis")
    guide.append("")
    
    for chunk in chunks:
        guide.append(f"### Chunk {chunk.chunk_id}: {chunk.title}")
        guide.append(f"**Type**: {chunk.chunk_type.value}")
        guide.append(f"**Complexity Score**: {chunk.complexity_score}")
        guide.append(f"**Lines**: {chunk.start_line}-{chunk.end_line}")
        guide.append(f"**Context**: {chunk.context_summary}")
        
        if chunk.sql_operations:
            guide.append(f"**SQL Operations**: {', '.join(chunk.sql_operations)}")
        
        if chunk.control_structures:
            guide.append(f"**Control Structures**: {', '.join(chunk.control_structures)}")
        
        if chunk.business_functions:
            guide.append(f"**Business Functions**: {', '.join(chunk.business_functions).replace('_', ' ').title()}")
        
        if chunk.variables_declared:
            guide.append(f"**Variables Declared**: {', '.join(chunk.variables_declared[:10])}")
            if len(chunk.variables_declared) > 10:
                guide.append(f"   (and {len(chunk.variables_declared) - 10} more...)")
        
        if chunk.tables_accessed:
            guide.append(f"**Tables/Views**: {', '.join(chunk.tables_accessed)}")
        
        if chunk.dependencies:
            guide.append(f"**Sequential Dependencies**: Chunks {', '.join(map(str, chunk.dependencies))}")
        
        if chunk.sub_chunk_info:
            info = chunk.sub_chunk_info
            guide.append(f"**Subdivision Info**: Part {info.sub_chunk_index} of {info.total_sub_chunks}")
            guide.append(f"**Parent Block**: {info.parent_block_type} (lines {info.parent_block_start}-{info.parent_block_end})")
        
        guide.append("")
        guide.append("**Code:**")
        guide.append("```sql")
        for line in chunk.lines:
            guide.append(line)
        guide.append("```")
        guide.append("")
        
        guide.append("**Sequential Analysis Questions:**")
        guide.append("1. How does this chunk build upon the previous chunks?")
        guide.append("2. What specific business logic or data processing occurs here?")
        guide.append("3. What variables or data from previous chunks are used?")
        guide.append("4. What outputs or state changes prepare for subsequent chunks?")
        guide.append("5. What error conditions or edge cases are handled?")
        guide.append("6. How does this contribute to the overall procedure workflow?")
        
        if chunk.continuation_to:
            guide.append("7. How does this chunk connect to its continuation in the next chunk?")
        
        guide.append("")
        guide.append("---")
        guide.append("")
    
    return "\n".join(guide)

def main():
    """Main function for command line usage"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Adaptive SQL stored procedure chunking analyzer')
    parser.add_argument('sql_file', help='Path to SQL file to analyze')
    parser.add_argument('--strategy', choices=['strict_logical', 'size_constrained', 'functional', 'hybrid'], 
                       default='hybrid', help='Chunking strategy')
    parser.add_argument('--target-size', type=int, default=60, help='Target lines per chunk')
    parser.add_argument('--min-size', type=int, default=10, help='Minimum lines per chunk')
    parser.add_argument('--max-size', type=int, default=120, help='Maximum lines per chunk')
    parser.add_argument('--force-subdivision', type=int, default=200, help='Force subdivision threshold')
    parser.add_argument('--output', '-o', help='Output file for analysis guide')
    parser.add_argument('--format', choices=['markdown', 'json'], default='markdown', help='Output format')
    
    args = parser.parse_args()
    
    # Read SQL file
    with open(args.sql_file, 'r', encoding='utf-8', errors='ignore') as f:
        sql_content = f.read()
    
    # Create analyzer with specified strategy
    strategy = ChunkStrategy(args.strategy)
    analyzer = AdaptiveSQLAnalyzer(
        strategy=strategy,
        target_chunk_size=args.target_size,
        min_chunk_size=args.min_size,
        max_chunk_size=args.max_size,
        force_subdivision_threshold=args.force_subdivision
    )
    
    chunks = analyzer.chunk_procedure(sql_content)
    
    # Generate output
    config = {
        'target_chunk_size': args.target_size,
        'max_chunk_size': args.max_size,
        'min_chunk_size': args.min_size,
        'force_subdivision_threshold': args.force_subdivision
    }
    
    if args.format == 'json':
        chunks_data = []
        for chunk in chunks:
            chunk_dict = {
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
                'dependencies': chunk.dependencies,
                'context_summary': chunk.context_summary,
                'business_functions': chunk.business_functions
            }
            
            if chunk.sub_chunk_info:
                chunk_dict['sub_chunk_info'] = {
                    'parent_block_type': chunk.sub_chunk_info.parent_block_type,
                    'parent_block_start': chunk.sub_chunk_info.parent_block_start,
                    'parent_block_end': chunk.sub_chunk_info.parent_block_end,
                    'sub_chunk_index': chunk.sub_chunk_info.sub_chunk_index,
                    'total_sub_chunks': chunk.sub_chunk_info.total_sub_chunks,
                    'subdivision_reason': chunk.sub_chunk_info.subdivision_reason
                }
            
            chunks_data.append(chunk_dict)
        
        output = json.dumps({
            'strategy': strategy.value,
            'config': config,
            'chunks': chunks_data
        }, indent=2)
    else:
        output = generate_adaptive_analysis_guide(chunks, strategy, config)
    
    # Write output
    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(output)
        print(f"Adaptive analysis guide written to {args.output}")
        print(f"Strategy: {strategy.value}")
        print(f"Created {len(chunks)} chunks for sequential analysis")
        print(f"Total complexity score: {sum(chunk.complexity_score for chunk in chunks)}")
        subdivided = sum(1 for chunk in chunks if chunk.sub_chunk_info)
        if subdivided:
            print(f"Subdivided {subdivided} large chunks for optimal size")
    else:
        print(output)

if __name__ == "__main__":
    main()
