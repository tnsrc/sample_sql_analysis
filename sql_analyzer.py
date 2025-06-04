#!/usr/bin/env python3
"""
Universal SQL Stored Procedure Business Logic Analyzer
Works across all business domains and SQL variants to extract patterns and structure
"""

import re
import json
from typing import List, Dict, Any, Tuple
from dataclasses import dataclass
from pathlib import Path

@dataclass
class BusinessRule:
    """Represents a business rule found in the code"""
    rule_type: str
    description: str
    line_number: int
    code_snippet: str
    pattern_matched: str
    confidence: str  # 'high', 'medium', 'low'

@dataclass
class ControlFlow:
    """Represents a control flow structure"""
    flow_type: str  # 'if', 'while', 'try_catch', 'goto', 'case'
    condition: str
    start_line: int
    end_line: int
    nesting_level: int
    complexity_factor: int

@dataclass
class DataOperation:
    """Represents a data operation (INSERT, UPDATE, DELETE, SELECT)"""
    operation_type: str
    table_name: str
    line_number: int
    description: str
    estimated_impact: str  # 'high', 'medium', 'low'

@dataclass
class DecisionPoint:
    """Represents a decision point in the SQL code"""
    line_number: int
    decision_type: str  # 'IF', 'ELSE_IF', 'CASE', 'WHILE', 'EXISTS'
    condition: str
    business_logic: str
    category: str  # 'validation', 'pricing', 'inventory', etc.
    complexity_level: str  # 'high', 'medium', 'low'
    source_code: str  # The actual source line
    code_block: List[str]  # The code block associated with this decision point

class UniversalSQLAnalyzer:
    def __init__(self):
        self.business_rules = []
        self.control_flows = []
        self.data_operations = []
        self.variables = {}
        self.parameters = {}
        
        # Universal SQL patterns that work across all domains
        self.universal_patterns = {
            'validation_patterns': [
                (r'(?:IF|WHERE)\s+.*(?:IS\s+NULL|IS\s+NOT\s+NULL)', 'null_validation', 'Null value validation'),
                (r'(?:IF|WHERE)\s+.*(?:<=|>=|<|>|=|<>|!=)\s*[0-9]+', 'threshold_validation', 'Numeric threshold validation'),
                (r'(?:IF|WHERE)\s+.*EXISTS\s*\(', 'existence_validation', 'Record existence validation'),
                (r'(?:IF|WHERE)\s+.*NOT\s+EXISTS\s*\(', 'non_existence_validation', 'Record non-existence validation'),
                (r'(?:IF|WHERE)\s+.*\bLEN\s*\(.*\)\s*[<>=]', 'length_validation', 'String length validation'),
                (r'(?:IF|WHERE)\s+.*\bISNULL\s*\(', 'null_handling', 'Null value handling'),
                (r'(?:IF|WHERE)\s+.*\bISDATE\s*\(', 'date_validation', 'Date format validation'),
                (r'(?:IF|WHERE)\s+.*\bISNUMERIC\s*\(', 'numeric_validation', 'Numeric format validation'),
            ],
            'calculation_patterns': [
                (r'SET\s+@\w+\s*=.*[+\-*/]', 'arithmetic_calculation', 'Arithmetic calculation'),
                (r'(?:SUM|COUNT|AVG|MIN|MAX|STDEV)\s*\(', 'aggregate_calculation', 'Aggregate calculation'),
                (r'CASE\s+WHEN.*THEN.*END', 'conditional_calculation', 'Conditional calculation'),
                (r'(?:ROUND|CEILING|FLOOR|ABS)\s*\(', 'mathematical_function', 'Mathematical function'),
                (r'(?:DATEDIFF|DATEADD|GETDATE|CURRENT_TIMESTAMP)', 'date_calculation', 'Date/time calculation'),
                (r'(?:SUBSTRING|LEFT|RIGHT|CHARINDEX|PATINDEX)', 'string_manipulation', 'String manipulation'),
            ],
            'transaction_patterns': [
                (r'BEGIN\s+TRANSACTION', 'transaction_start', 'Transaction initiation'),
                (r'COMMIT\s+TRANSACTION', 'transaction_commit', 'Transaction commit'),
                (r'ROLLBACK\s+TRANSACTION', 'transaction_rollback', 'Transaction rollback'),
                (r'SAVE\s+TRANSACTION', 'transaction_savepoint', 'Transaction savepoint'),
                (r'SET\s+XACT_ABORT', 'transaction_control', 'Transaction abort control'),
            ],
            'error_handling_patterns': [
                (r'BEGIN\s+TRY', 'try_block', 'Error handling try block'),
                (r'BEGIN\s+CATCH', 'catch_block', 'Error handling catch block'),
                (r'RAISERROR\s*\(', 'error_raising', 'Error message raising'),
                (r'THROW\s+', 'error_throwing', 'Exception throwing'),
                (r'@@ERROR', 'error_checking', 'Error status checking'),
                (r'ERROR_(?:MESSAGE|NUMBER|SEVERITY|STATE|PROCEDURE|LINE)\s*\(\)', 'error_info', 'Error information retrieval'),
            ],
            'performance_patterns': [
                (r'SET\s+NOCOUNT\s+(?:ON|OFF)', 'performance_tuning', 'Row count optimization'),
                (r'WITH\s*\((?:NOLOCK|READUNCOMMITTED)', 'isolation_hint', 'Isolation level hint'),
                (r'OPTION\s*\(.*\)', 'query_hint', 'Query optimization hint'),
                (r'INDEX\s*=\s*', 'index_hint', 'Index usage hint'),
            ],
            'security_patterns': [
                (r'QUOTENAME\s*\(', 'sql_injection_protection', 'SQL injection protection'),
                (r'sp_executesql', 'parameterized_sql', 'Parameterized dynamic SQL'),
                (r'HAS_PERMS_BY_NAME\s*\(', 'permission_check', 'Permission validation'),
                (r'IS_MEMBER\s*\(', 'role_check', 'Role membership check'),
            ]
        }
        
    def analyze_procedure(self, sql_content: str, procedure_name: str = None) -> Dict[str, Any]:
        """Main analysis function that works for any SQL stored procedure"""
        lines = sql_content.split('\n')
        
        # Extract basic info
        proc_info = self._extract_procedure_info(sql_content)
        
        # Analyze different aspects
        control_flows = self._analyze_control_flow(lines)
        business_rules = self._extract_universal_patterns(lines)
        data_ops = self._analyze_data_operations(lines)
        complexity_analysis = self._analyze_complexity(lines)
        structure_analysis = self._analyze_structure(lines)
        decision_points = self._analyze_decision_points(lines)
        
        return {
            'procedure_info': proc_info,
            'control_flows': control_flows,
            'business_rules': business_rules,
            'data_operations': data_ops,
            'complexity_analysis': complexity_analysis,
            'structure_analysis': structure_analysis,
            'decision_points': decision_points,
            'summary': self._generate_summary(proc_info, control_flows, business_rules, complexity_analysis)
        }
    
    def _extract_procedure_info(self, sql_content: str) -> Dict[str, Any]:
        """Extract procedure name, parameters, and basic info"""
        # Extract procedure name
        proc_patterns = [
            r'CREATE\s+(?:OR\s+ALTER\s+)?PROCEDURE\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)',
            r'ALTER\s+PROCEDURE\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)',
            r'CREATE\s+(?:OR\s+ALTER\s+)?PROC\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)'
        ]
        
        proc_name = "Unknown"
        for pattern in proc_patterns:
            proc_match = re.search(pattern, sql_content, re.IGNORECASE)
            if proc_match:
                proc_name = proc_match.group(1).strip('[]')
                break
        
        # Extract parameters with more comprehensive pattern
        param_pattern = r'@(\w+)\s+([A-Z_]+(?:\([^)]+\))?(?:\s*=\s*[^,\s)]+)?(?:\s+(?:OUTPUT|OUT|READONLY))?)'
        parameters = re.findall(param_pattern, sql_content, re.IGNORECASE)
        
        # Extract tables/views/functions mentioned
        table_patterns = [
            r'(?:FROM|JOIN|UPDATE|INSERT\s+INTO|DELETE\s+FROM)\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)',
            r'EXEC(?:UTE)?\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)',
            r'EXISTS\s*\(\s*SELECT.*FROM\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)'
        ]
        
        tables = set()
        for pattern in table_patterns:
            matches = re.findall(pattern, sql_content, re.IGNORECASE)
            tables.update([match.strip('[]') for match in matches if not match.startswith('@')])
        
        # Count variables and cursors
        variables = len(re.findall(r'DECLARE\s+@\w+', sql_content, re.IGNORECASE))
        cursors = len(re.findall(r'DECLARE\s+\w+\s+CURSOR', sql_content, re.IGNORECASE))
        
        return {
            'name': proc_name,
            'parameters': [{'name': p[0], 'type': p[1]} for p in parameters],
            'tables_involved': list(tables),
            'line_count': len(sql_content.split('\n')),
            'variable_count': variables,
            'cursor_count': cursors,
            'character_count': len(sql_content)
        }
    
    def _analyze_control_flow(self, lines: List[str]) -> List[Dict[str, Any]]:
        """Analyze control flow structures universally"""
        flows = []
        stack = []
        nesting_level = 0
        
        for i, line in enumerate(lines, 1):
            line_clean = line.strip().upper()
            original_line = line.strip()
            
            # IF statements
            if re.search(r'\bIF\b', line_clean):
                condition = re.sub(r'^\s*IF\s+', '', original_line, flags=re.IGNORECASE).strip()
                nesting_level += 1
                stack.append({
                    'type': 'IF',
                    'condition': condition,
                    'start_line': i,
                    'nesting': nesting_level,
                    'complexity_factor': 2
                })
            
            # WHILE loops
            elif re.search(r'\bWHILE\b', line_clean):
                condition = re.sub(r'^\s*WHILE\s+', '', original_line, flags=re.IGNORECASE).strip()
                nesting_level += 1
                stack.append({
                    'type': 'WHILE',
                    'condition': condition,
                    'start_line': i,
                    'nesting': nesting_level,
                    'complexity_factor': 3
                })
            
            # CASE statements
            elif re.search(r'\bCASE\b', line_clean) and not re.search(r'\bEND\s+CASE\b', line_clean):
                nesting_level += 1
                stack.append({
                    'type': 'CASE',
                    'condition': 'Case expression',
                    'start_line': i,
                    'nesting': nesting_level,
                    'complexity_factor': 2
                })
            
            # TRY blocks
            elif 'BEGIN TRY' in line_clean:
                nesting_level += 1
                stack.append({
                    'type': 'TRY',
                    'condition': 'Exception handling',
                    'start_line': i,
                    'nesting': nesting_level,
                    'complexity_factor': 2
                })
            
            # CATCH blocks
            elif 'BEGIN CATCH' in line_clean:
                if stack and stack[-1]['type'] == 'TRY':
                    # Convert TRY to TRY_CATCH
                    stack[-1]['type'] = 'TRY_CATCH'
                    stack[-1]['complexity_factor'] = 3
            
            # END statements
            elif re.search(r'\bEND\b(?:\s*;)?\s*$', line_clean):
                if stack:
                    flow = stack.pop()
                    flow['end_line'] = i
                    flows.append(flow)
                    nesting_level = max(0, nesting_level - 1)
        
        # Handle unclosed blocks
        for flow in stack:
            flow['end_line'] = len(lines)
            flows.append(flow)
        
        return flows
    
    def _extract_universal_patterns(self, lines: List[str]) -> List[Dict[str, Any]]:
        """Extract business rules using universal patterns"""
        rules = []
        
        for category, patterns in self.universal_patterns.items():
            for i, line in enumerate(lines, 1):
                for pattern, rule_type, description in patterns:
                    matches = re.findall(pattern, line, re.IGNORECASE)
                    if matches:
                        # Determine confidence based on pattern specificity
                        confidence = 'high' if len(matches) == 1 else 'medium'
                        if '.*' in pattern:
                            confidence = 'medium'
                        
                        rules.append({
                            'category': category,
                            'type': rule_type,
                            'description': description,
                            'line_number': i,
                            'code_snippet': line.strip(),
                            'pattern_matched': pattern,
                            'confidence': confidence,
                            'matches': matches if isinstance(matches[0], str) else [str(m) for m in matches]
                        })
        
        return rules
    
    def _analyze_data_operations(self, lines: List[str]) -> List[Dict[str, Any]]:
        """Analyze data operations with impact estimation"""
        operations = []
        
        for i, line in enumerate(lines, 1):
            line_upper = line.strip().upper()
            original_line = line.strip()
            
            # INSERT operations
            if re.search(r'\bINSERT\s+INTO\b', line_upper):
                table_match = re.search(r'INSERT\s+INTO\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)', original_line, re.IGNORECASE)
                table_name = table_match.group(1) if table_match else 'Unknown'
                
                # Estimate impact
                impact = 'high' if re.search(r'SELECT.*FROM', line_upper) else 'medium'
                
                operations.append({
                    'type': 'INSERT',
                    'table': table_name,
                    'line_number': i,
                    'description': f'Insert data into {table_name}',
                    'estimated_impact': impact,
                    'has_subquery': 'SELECT' in line_upper
                })
            
            # UPDATE operations
            elif re.search(r'\bUPDATE\b', line_upper) and not re.search(r'STATISTICS', line_upper):
                table_match = re.search(r'UPDATE\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)', original_line, re.IGNORECASE)
                table_name = table_match.group(1) if table_match else 'Unknown'
                
                # Estimate impact based on WHERE clause
                impact = 'low' if re.search(r'WHERE.*=.*@', line_upper) else 'high'
                
                operations.append({
                    'type': 'UPDATE',
                    'table': table_name,
                    'line_number': i,
                    'description': f'Update data in {table_name}',
                    'estimated_impact': impact,
                    'has_where_clause': 'WHERE' in line_upper
                })
            
            # DELETE operations
            elif re.search(r'\bDELETE\s+FROM\b', line_upper):
                table_match = re.search(r'DELETE\s+FROM\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)', original_line, re.IGNORECASE)
                table_name = table_match.group(1) if table_match else 'Unknown'
                
                # DELETE operations are typically high impact
                impact = 'high'
                
                operations.append({
                    'type': 'DELETE',
                    'table': table_name,
                    'line_number': i,
                    'description': f'Delete data from {table_name}',
                    'estimated_impact': impact,
                    'has_where_clause': 'WHERE' in line_upper
                })
            
            # SELECT operations (only standalone, not subqueries)
            elif (re.search(r'^\s*SELECT\b', line_upper) and 
                  not re.search(r'INSERT|UPDATE|DELETE', line_upper)):
                table_match = re.search(r'FROM\s+(\[?\w+\]?(?:\.\[?\w+\]?)*)', original_line, re.IGNORECASE)
                table_name = table_match.group(1) if table_match else 'Unknown'
                
                operations.append({
                    'type': 'SELECT',
                    'table': table_name,
                    'line_number': i,
                    'description': f'Query data from {table_name}',
                    'estimated_impact': 'low',
                    'has_joins': 'JOIN' in line_upper
                })
        
        return operations
    
    def _analyze_complexity(self, lines: List[str]) -> Dict[str, Any]:
        """Analyze code complexity using multiple metrics"""
        metrics = {
            'cyclomatic_complexity': 1,  # Base complexity
            'nesting_depth': 0,
            'max_nesting_depth': 0,
            'decision_points': 0,
            'loop_count': 0,
            'exception_blocks': 0,
            'dynamic_sql_usage': 0,
            'cursor_usage': 0
        }
        
        current_nesting = 0
        
        for line in lines:
            line_upper = line.strip().upper()
            
            # Decision points increase cyclomatic complexity
            if re.search(r'\b(?:IF|WHILE|CASE\s+WHEN|AND|OR)\b', line_upper):
                metrics['cyclomatic_complexity'] += 1
                metrics['decision_points'] += 1
            
            # Track nesting
            if re.search(r'\b(?:BEGIN|IF|WHILE|TRY|CASE)\b', line_upper):
                current_nesting += 1
                metrics['max_nesting_depth'] = max(metrics['max_nesting_depth'], current_nesting)
            elif re.search(r'\bEND\b', line_upper):
                current_nesting = max(0, current_nesting - 1)
            
            metrics['nesting_depth'] = current_nesting
            
            # Count specific constructs
            if re.search(r'\bWHILE\b', line_upper):
                metrics['loop_count'] += 1
            
            if re.search(r'\b(?:TRY|CATCH)\b', line_upper):
                metrics['exception_blocks'] += 1
            
            if re.search(r'EXEC\s*\(|sp_executesql', line_upper):
                metrics['dynamic_sql_usage'] += 1
            
            if re.search(r'CURSOR|FETCH|OPEN|CLOSE', line_upper):
                metrics['cursor_usage'] += 1
        
        # Calculate overall complexity score
        complexity_score = (
            metrics['cyclomatic_complexity'] +
            metrics['max_nesting_depth'] * 2 +
            metrics['loop_count'] * 3 +
            metrics['exception_blocks'] +
            metrics['dynamic_sql_usage'] * 2 +
            metrics['cursor_usage'] * 4
        )
        
        metrics['overall_complexity_score'] = complexity_score
        
        if complexity_score < 10:
            metrics['complexity_rating'] = 'Low'
        elif complexity_score < 25:
            metrics['complexity_rating'] = 'Medium'
        elif complexity_score < 50:
            metrics['complexity_rating'] = 'High'
        else:
            metrics['complexity_rating'] = 'Very High'
        
        return metrics
    
    def _analyze_structure(self, lines: List[str]) -> Dict[str, Any]:
        """Analyze the structural characteristics of the procedure"""
        structure = {
            'total_lines': len(lines),
            'code_lines': 0,
            'comment_lines': 0,
            'empty_lines': 0,
            'longest_line': 0,
            'average_line_length': 0,
            'comment_ratio': 0,
            'has_documentation': False,
            'sections': []
        }
        
        total_length = 0
        current_section = None
        
        for i, line in enumerate(lines, 1):
            clean_line = line.strip()
            
            if not clean_line:
                structure['empty_lines'] += 1
            elif clean_line.startswith('--') or clean_line.startswith('/*'):
                structure['comment_lines'] += 1
                # Check for section headers
                if len(clean_line) > 20 and any(char in clean_line for char in ['=', '-', '*']):
                    if current_section:
                        current_section['end_line'] = i - 1
                        structure['sections'].append(current_section)
                    current_section = {
                        'title': clean_line.strip('/*-* '),
                        'start_line': i,
                        'end_line': None
                    }
            else:
                structure['code_lines'] += 1
            
            line_length = len(line)
            structure['longest_line'] = max(structure['longest_line'], line_length)
            total_length += line_length
        
        # Close last section
        if current_section:
            current_section['end_line'] = len(lines)
            structure['sections'].append(current_section)
        
        structure['average_line_length'] = total_length / len(lines) if lines else 0
        structure['comment_ratio'] = structure['comment_lines'] / len(lines) if lines else 0
        structure['has_documentation'] = structure['comment_ratio'] > 0.1
        
        return structure
    
    def _analyze_decision_points(self, lines: List[str]) -> Dict[str, Any]:
        """Analyze decision points in SQL code with comprehensive business logic categorization"""
        decision_points = []
        decision_stats = {
            'if_statements': 0,
            'else_if_statements': 0,
            'case_expressions': 0,
            'while_loops': 0,
            'exists_checks': 0,
            'total_decision_points': 0
        }
        
        # Business logic patterns for categorization
        business_logic_patterns = {
            'validation_logic': [
                r'IS\s+NULL', r'IS\s+NOT\s+NULL', r'LEN\s*\(', r'EXISTS\s*\(',
                r'NOT\s+EXISTS', r'<=|>=|<|>|=|<>|!=', r'ISNULL\s*\(',
                r'ISDATE\s*\(', r'ISNUMERIC\s*\(', r'@\w+\s*IS\s+NULL'
            ],
            'pricing_logic': [
                r'Price|Cost|Amount|Discount|Fee|Rate|Charge|Total',
                r'CustomerType|VIP|Corporate|Wholesale', r'Volume|Quantity',
                r'Seasonal|Holiday|Promotion|Loyalty', r'Tax|Shipping'
            ],
            'order_processing': [
                r'Order|Payment|Fraud|Status|Workflow|Process',
                r'Credit|Limit|Balance|Approval', r'Rush|Priority',
                r'Confirmation|Notification', r'Backorder|Fulfillment'
            ],
            'inventory_management': [
                r'Inventory|Stock|Warehouse|Allocation|Reserve',
                r'Available|Quantity|Transfer|Restock', r'Product|Item'
            ],
            'customer_management': [
                r'Customer|Account|Profile|Status|Tier',
                r'Suspend|Active|Delete|Create|Update', r'Credit|Risk'
            ],
            'returns_processing': [
                r'Return|Refund|Exchange|Condition|Defective',
                r'Damaged|Wrong|Changed.*Mind|Approval'
            ],
            'analytics_logic': [
                r'Report|Analysis|Trend|Forecast|Cohort',
                r'Revenue|Growth|Retention|Churn|Segment'
            ]
        }
        
        # First pass: identify all decision points
        for i, line in enumerate(lines, 1):
            original_line = line.strip()
            line_upper = line.strip().upper()
            
            # Skip empty lines and comments
            if not original_line or original_line.startswith('--') or original_line.startswith('/*'):
                continue
            
            decision_point = None
            
            # IF statements (primary conditional logic)
            if_match = re.search(r'^\s*IF\s+(.+?)(?:\s+BEGIN|\s*$)', original_line, re.IGNORECASE)
            if if_match:
                condition = if_match.group(1).strip()
                decision_point = {
                    'line_number': i,
                    'decision_type': 'IF',
                    'condition': condition,
                    'business_logic': self._extract_business_logic(condition, business_logic_patterns),
                    'category': self._categorize_decision_point(condition, business_logic_patterns),
                    'complexity_level': self._assess_decision_complexity(condition),
                    'source_code': original_line,
                    'code_block': []
                }
                decision_stats['if_statements'] += 1
            
            # ELSE IF statements (secondary conditional branches)
            elif_match = re.search(r'^\s*ELSE\s+IF\s+(.+?)(?:\s+BEGIN|\s*$)', original_line, re.IGNORECASE)
            if elif_match:
                condition = elif_match.group(1).strip()
                decision_point = {
                    'line_number': i,
                    'decision_type': 'ELSE_IF',
                    'condition': condition,
                    'business_logic': self._extract_business_logic(condition, business_logic_patterns),
                    'category': self._categorize_decision_point(condition, business_logic_patterns),
                    'complexity_level': self._assess_decision_complexity(condition),
                    'source_code': original_line,
                    'code_block': []
                }
                decision_stats['else_if_statements'] += 1
            
            # CASE expressions (multi-value conditional logic)
            case_match = re.search(r'CASE\s+(?:WHEN\s+(.+?)\s+THEN|(.+?)\s+WHEN)', original_line, re.IGNORECASE)
            if case_match:
                condition = (case_match.group(1) or case_match.group(2) or 'CASE expression').strip()
                decision_point = {
                    'line_number': i,
                    'decision_type': 'CASE',
                    'condition': condition,
                    'business_logic': self._extract_business_logic(condition, business_logic_patterns),
                    'category': self._categorize_decision_point(condition, business_logic_patterns),
                    'complexity_level': self._assess_decision_complexity(condition),
                    'source_code': original_line,
                    'code_block': []
                }
                decision_stats['case_expressions'] += 1
            
            # WHILE loops (iterative processing)
            while_match = re.search(r'^\s*WHILE\s+(.+?)(?:\s+BEGIN|\s*$)', original_line, re.IGNORECASE)
            if while_match:
                condition = while_match.group(1).strip()
                decision_point = {
                    'line_number': i,
                    'decision_type': 'WHILE',
                    'condition': condition,
                    'business_logic': self._extract_business_logic(condition, business_logic_patterns),
                    'category': self._categorize_decision_point(condition, business_logic_patterns),
                    'complexity_level': 'high',  # Loops are inherently complex
                    'source_code': original_line,
                    'code_block': []
                }
                decision_stats['while_loops'] += 1
            
            # EXISTS checks (data validation conditions)
            exists_match = re.search(r'(?:NOT\s+)?EXISTS\s*\(([^)]+)\)', original_line, re.IGNORECASE)
            if exists_match and not if_match and not elif_match:  # Avoid double counting
                condition = f"EXISTS check: {exists_match.group(1).strip()}"
                decision_point = {
                    'line_number': i,
                    'decision_type': 'EXISTS',
                    'condition': condition,
                    'business_logic': self._extract_business_logic(condition, business_logic_patterns),
                    'category': self._categorize_decision_point(condition, business_logic_patterns),
                    'complexity_level': self._assess_decision_complexity(condition),
                    'source_code': original_line,
                    'code_block': []
                }
                decision_stats['exists_checks'] += 1
            
            if decision_point:
                decision_points.append(decision_point)
                decision_stats['total_decision_points'] += 1
        
        # Second pass: capture code blocks for each decision point
        decision_points = self._capture_code_blocks(lines, decision_points)
        
        # Categorize decision points by business logic
        categories = {}
        for dp in decision_points:
            category = dp['category']
            if category not in categories:
                categories[category] = []
            categories[category].append(dp)
        
        return {
            'decision_points': decision_points,
            'statistics': decision_stats,
            'categories': categories,
            'summary': {
                'total_decision_points': decision_stats['total_decision_points'],
                'most_common_type': max(
                    ['if_statements', 'else_if_statements', 'case_expressions', 'while_loops', 'exists_checks'],
                    key=lambda x: decision_stats[x]
                ).replace('_', ' ').title(),
                'primary_business_category': max(categories.keys(), key=lambda x: len(categories[x])) if categories else 'unknown',
                'complexity_distribution': self._get_complexity_distribution(decision_points)
            }
        }
    
    def _capture_code_blocks(self, lines: List[str], decision_points: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Capture the code blocks associated with each decision point"""
        for dp in decision_points:
            start_line = dp['line_number']
            code_block = []
            
            # Find the code block for this decision point
            nesting_level = 0
            in_block = False
            begin_found = False
            
            for i in range(start_line - 1, min(start_line + 50, len(lines))):  # Increased limit to 50 lines
                line = lines[i].strip()
                line_upper = line.upper()
                
                # Add the decision point line itself
                if i == start_line - 1:
                    code_block.append(line)
                    # Check if BEGIN is on the same line
                    if 'BEGIN' in line_upper:
                        in_block = True
                        begin_found = True
                        nesting_level = 1
                    continue
                
                # Skip empty lines and comments unless we're already in a block
                if not line or line.startswith('--') or line.startswith('/*'):
                    if in_block:
                        code_block.append(line)
                    continue
                
                # Look for BEGIN if we haven't found it yet
                if not begin_found and line_upper.strip() == 'BEGIN':
                    in_block = True
                    begin_found = True
                    nesting_level = 1
                    code_block.append(line)
                    continue
                
                # If we're in a block, capture everything
                if in_block:
                    # Track nesting for BEGIN/END blocks
                    if re.search(r'\bBEGIN\b', line_upper):
                        nesting_level += 1
                    elif re.search(r'\bEND\b', line_upper):
                        nesting_level -= 1
                    
                    # Always add the line first (including END statements)
                    code_block.append(line)
                    
                    # Then check if we should break after adding the END
                    if re.search(r'\bEND\b', line_upper) and nesting_level <= 0:
                        break
                
                # For single-line statements (IF without BEGIN)
                elif (dp['decision_type'] in ['IF', 'ELSE_IF'] and 
                      not begin_found and 
                      not re.search(r'^\s*(?:IF|ELSE|WHILE|END|CASE)\b', line_upper)):
                    code_block.append(line)
                    break
                
                # For CASE expressions, capture until END
                elif dp['decision_type'] == 'CASE':
                    code_block.append(line)
                    if re.search(r'\bEND\b', line_upper):
                        break
                
                # For WHILE loops, capture until we find the loop body
                elif dp['decision_type'] == 'WHILE':
                    if 'BEGIN' in line_upper:
                        in_block = True
                        begin_found = True
                        nesting_level = 1
                        code_block.append(line)
                    elif not begin_found:
                        # Single statement loop
                        code_block.append(line)
                        break
                
                # Stop at next decision point at same level
                elif re.search(r'^\s*(?:IF|ELSE|WHILE|END)\b', line_upper) and not in_block:
                    break
            
            # Ensure we have at least the decision point line
            if not code_block:
                code_block = [lines[start_line - 1].strip()]
            
            dp['code_block'] = code_block
        
        return decision_points
    
    def _extract_business_logic(self, condition: str, patterns: Dict[str, List[str]]) -> str:
        """Extract business logic description from condition"""
        condition_lower = condition.lower()
        
        # Check for specific business logic patterns
        if 'null' in condition_lower:
            return 'Null value validation'
        elif any(op in condition for op in ['>=', '<=', '>', '<', '=', '!=']):
            if any(word in condition_lower for word in ['price', 'cost', 'amount', 'total']):
                return 'Price/cost comparison'
            elif any(word in condition_lower for word in ['quantity', 'count', 'limit']):
                return 'Quantity/limit validation'
            elif any(word in condition_lower for word in ['date', 'day', 'month', 'year']):
                return 'Date/time comparison'
            else:
                return 'Numeric threshold validation'
        elif 'exists' in condition_lower:
            return 'Record existence validation'
        elif 'in (' in condition_lower:
            return 'Value set membership check'
        elif any(word in condition_lower for word in ['customer', 'account', 'user']):
            return 'Customer/account validation'
        elif any(word in condition_lower for word in ['inventory', 'stock', 'warehouse']):
            return 'Inventory management logic'
        elif any(word in condition_lower for word in ['order', 'payment', 'transaction']):
            return 'Order/payment processing'
        else:
            return 'Business rule validation'
    
    def _categorize_decision_point(self, condition: str, patterns: Dict[str, List[str]]) -> str:
        """Categorize decision point based on business logic patterns"""
        condition_lower = condition.lower()
        
        # Score each category based on pattern matches
        category_scores = {}
        for category, pattern_list in patterns.items():
            score = 0
            for pattern in pattern_list:
                matches = len(re.findall(pattern.lower(), condition_lower))
                score += matches
            category_scores[category] = score
        
        # Return category with highest score, or 'general' if no clear match
        if category_scores and max(category_scores.values()) > 0:
            return max(category_scores, key=category_scores.get)
        else:
            return 'general_logic'
    
    def _assess_decision_complexity(self, condition: str) -> str:
        """Assess the complexity level of a decision point"""
        # Count complexity indicators
        complexity_indicators = [
            len(re.findall(r'\bAND\b|\bOR\b', condition, re.IGNORECASE)),  # Logical operators
            len(re.findall(r'\(.*\)', condition)),  # Nested expressions
            len(re.findall(r'(?:SELECT|UPDATE|INSERT|DELETE)', condition, re.IGNORECASE)),  # Subqueries
            len(re.findall(r'(?:CASE|WHEN|THEN)', condition, re.IGNORECASE)),  # Case expressions
            len(re.findall(r'@\w+', condition))  # Variable references
        ]
        
        total_complexity = sum(complexity_indicators)
        
        if total_complexity >= 5:
            return 'high'
        elif total_complexity >= 2:
            return 'medium'
        else:
            return 'low'
    
    def _get_complexity_distribution(self, decision_points: List[Dict[str, Any]]) -> Dict[str, int]:
        """Get distribution of complexity levels"""
        distribution = {'low': 0, 'medium': 0, 'high': 0}
        for dp in decision_points:
            distribution[dp['complexity_level']] += 1
        return distribution

    def _generate_summary(self, proc_info: Dict, control_flows: List, 
                         rules: List, complexity: Dict) -> Dict[str, Any]:
        """Generate a comprehensive summary"""
        return {
            'procedure_name': proc_info['name'],
            'total_lines': proc_info['line_count'],
            'total_parameters': len(proc_info['parameters']),
            'total_tables': len(proc_info['tables_involved']),
            'total_variables': proc_info['variable_count'],
            'total_cursors': proc_info['cursor_count'],
            'control_flow_count': len(control_flows),
            'business_rule_count': len(rules),
            'complexity_score': complexity['overall_complexity_score'],
            'complexity_rating': complexity['complexity_rating'],
            'estimated_maintenance_effort': self._estimate_maintenance_effort(proc_info, complexity, rules)
        }
    
    def _estimate_maintenance_effort(self, proc_info: Dict, complexity: Dict, rules: List) -> str:
        """Estimate maintenance effort based on various factors"""
        effort_score = 0
        
        # Size factor
        effort_score += proc_info['line_count'] // 100
        
        # Complexity factor
        effort_score += complexity['overall_complexity_score'] // 10
        
        # Cursor factor (high maintenance)
        effort_score += proc_info['cursor_count'] * 3
        
        # Business rule factor
        effort_score += len(rules) // 10
        
        if effort_score < 3:
            return 'Low'
        elif effort_score < 8:
            return 'Medium'
        elif effort_score < 15:
            return 'High'
        else:
            return 'Very High'

def generate_universal_analysis_report(analysis_result: Dict[str, Any]) -> str:
    """Generate a comprehensive analysis report for any stored procedure"""
    report = []
    
    # Header
    report.append("# Universal SQL Stored Procedure Analysis Report")
    report.append("=" * 60)
    report.append("")
    
    # Procedure Info
    info = analysis_result['procedure_info']
    summary = analysis_result['summary']
    
    report.append("## Procedure Overview")
    report.append(f"**Procedure Name:** {info['name']}")
    report.append(f"**Total Lines:** {info['line_count']:,}")
    report.append(f"**Parameters:** {len(info['parameters'])}")
    report.append(f"**Variables:** {info['variable_count']}")
    report.append(f"**Tables/Views:** {len(info['tables_involved'])}")
    if info['cursor_count'] > 0:
        report.append(f"**Cursors:** {info['cursor_count']}")
    report.append("")
    
    # Complexity Analysis
    complexity = analysis_result['complexity_analysis']
    report.append("## Complexity Analysis")
    report.append(f"- **Overall Complexity:** {complexity['complexity_rating']} (Score: {complexity['overall_complexity_score']})")
    report.append(f"- **Cyclomatic Complexity:** {complexity['cyclomatic_complexity']}")
    report.append(f"- **Maximum Nesting Depth:** {complexity['max_nesting_depth']}")
    report.append(f"- **Decision Points:** {complexity['decision_points']}")
    if complexity['loop_count'] > 0:
        report.append(f"- **Loops:** {complexity['loop_count']}")
    if complexity['dynamic_sql_usage'] > 0:
        report.append(f"- **Dynamic SQL Usage:** {complexity['dynamic_sql_usage']}")
    report.append(f"- **Estimated Maintenance Effort:** {summary['estimated_maintenance_effort']}")
    report.append("")
    
    # Structure Analysis
    structure = analysis_result['structure_analysis']
    report.append("## Code Structure")
    report.append(f"- **Code Lines:** {structure['code_lines']:,}")
    report.append(f"- **Comment Lines:** {structure['comment_lines']:,}")
    report.append(f"- **Empty Lines:** {structure['empty_lines']:,}")
    report.append(f"- **Comment Ratio:** {structure['comment_ratio']:.1%}")
    report.append(f"- **Documentation Quality:** {'Good' if structure['has_documentation'] else 'Poor'}")
    report.append(f"- **Average Line Length:** {structure['average_line_length']:.1f} characters")
    report.append("")
    
    # Decision Points Analysis
    if 'decision_points' in analysis_result and analysis_result['decision_points']:
        decision_analysis = analysis_result['decision_points']
        stats = decision_analysis['statistics']
        categories = decision_analysis['categories']
        summary = decision_analysis['summary']
        
        report.append("## Decision Points Analysis")
        report.append(f"**Total Decision Points:** {stats['total_decision_points']}")
        report.append("")
        
        # Statistics breakdown
        report.append("### Decision Point Statistics")
        report.append(f"- **IF Statements:** {stats['if_statements']}")
        report.append(f"- **ELSE IF Statements:** {stats['else_if_statements']}")
        report.append(f"- **CASE Expressions:** {stats['case_expressions']}")
        report.append(f"- **WHILE Loops:** {stats['while_loops']}")
        report.append(f"- **EXISTS Checks:** {stats['exists_checks']}")
        report.append(f"- **Most Common Type:** {summary['most_common_type']}")
        report.append(f"- **Primary Business Category:** {summary['primary_business_category'].replace('_', ' ').title()}")
        report.append("")
        
        # Complexity distribution
        report.append("### Complexity Distribution")
        complexity_dist = summary['complexity_distribution']
        for level, count in complexity_dist.items():
            if count > 0:
                percentage = (count / stats['total_decision_points']) * 100
                report.append(f"- **{level.title()} Complexity:** {count} ({percentage:.1f}%)")
        report.append("")
        
        # Business logic categories
        if categories:
            report.append("### Business Logic Categories")
            sorted_categories = sorted(categories.items(), key=lambda x: len(x[1]), reverse=True)
            
            for category, decision_points in sorted_categories:
                category_display = category.replace('_', ' ').title()
                count = len(decision_points)
                percentage = (count / stats['total_decision_points']) * 100
                report.append(f"#### {category_display} ({count} points - {percentage:.1f}%)")
                
                # Show top 5 decision points in this category
                for dp in decision_points[:5]:
                    complexity_icon = "🔴" if dp['complexity_level'] == 'high' else "🟡" if dp['complexity_level'] == 'medium' else "🟢"
                    type_display = dp['decision_type'].replace('_', ' ')
                    report.append(f"- {complexity_icon} **Line {dp['line_number']}** ({type_display}): {dp['business_logic']}")
                    
                    # Show the source code and code block
                    report.append(f"  **Source:** `{dp['source_code']}`")
                    if dp['code_block'] and len(dp['code_block']) > 1:
                        report.append(f"  **Code Block:**")
                        report.append(f"  ```sql")
                        for block_line in dp['code_block']:
                            report.append(f"  {block_line}")
                        report.append(f"  ```")
                    elif dp['code_block'] and len(dp['code_block']) == 1:
                        report.append(f"  **Single Statement:** `{dp['code_block'][0]}`")
                    else:
                        # Fallback to condition if no code block captured
                        if len(dp['condition']) <= 80:
                            report.append(f"  **Condition:**")
                            report.append(f"  ```sql")
                            report.append(f"  {dp['condition']}")
                            report.append(f"  ```")
                        else:
                            report.append(f"  **Condition:** {dp['condition'][:80]}...")
                    
                    report.append("")  # Add spacing between decision points
                
                if len(decision_points) > 5:
                    report.append(f"  *... and {len(decision_points) - 5} more decision points*")
                report.append("")
    
    # Business Rules by Category
    if analysis_result['business_rules']:
        report.append("## Identified Patterns & Rules")
        
        # Group by category
        rules_by_category = {}
        for rule in analysis_result['business_rules']:
            category = rule['category']
            if category not in rules_by_category:
                rules_by_category[category] = []
            rules_by_category[category].append(rule)
        
        for category, rules in rules_by_category.items():
            report.append(f"### {category.replace('_', ' ').title()}")
            for rule in rules[:5]:  # Show top 5 per category
                confidence_icon = "🔴" if rule['confidence'] == 'high' else "🟡" if rule['confidence'] == 'medium' else "🟢"
                report.append(f"- {confidence_icon} **Line {rule['line_number']}:** {rule['description']}")
                if len(rule['code_snippet']) < 100:
                    report.append(f"  ```sql")
                    report.append(f"  {rule['code_snippet']}")
                    report.append(f"  ```")
            if len(rules) > 5:
                report.append(f"  *... and {len(rules) - 5} more*")
            report.append("")
    
    # Data Operations
    if analysis_result['data_operations']:
        report.append("## Data Operations")
        operations_by_type = {}
        for op in analysis_result['data_operations']:
            op_type = op['type']
            if op_type not in operations_by_type:
                operations_by_type[op_type] = []
            operations_by_type[op_type].append(op)
        
        for op_type, ops in operations_by_type.items():
            report.append(f"### {op_type} Operations ({len(ops)})")
            for op in ops[:10]:  # Show first 10
                impact_icon = "🔴" if op['estimated_impact'] == 'high' else "🟡" if op['estimated_impact'] == 'medium' else "🟢"
                report.append(f"- {impact_icon} **{op['table']}** (Line {op['line_number']})")
            if len(ops) > 10:
                report.append(f"  *... and {len(ops) - 10} more*")
            report.append("")
    
    # Control Flow
    if analysis_result['control_flows']:
        report.append("## Control Flow Analysis")
        total_complexity = sum(flow['complexity_factor'] for flow in analysis_result['control_flows'])
        report.append(f"**Total Control Structures:** {len(analysis_result['control_flows'])}")
        report.append(f"**Control Flow Complexity:** {total_complexity}")
        report.append("")
        
        for flow in analysis_result['control_flows']:
            lines_span = f"Lines {flow['start_line']}-{flow.get('end_line', '?')}"
            report.append(f"- **{flow['type']}** ({lines_span}): {flow['condition'][:80]}{'...' if len(flow['condition']) > 80 else ''}")
        report.append("")
    
    # Tables and Dependencies
    if info['tables_involved']:
        report.append("## Database Objects")
        report.append("**Tables/Views/Functions Referenced:**")
        for table in sorted(info['tables_involved']):
            report.append(f"- {table}")
        report.append("")
    
    # Recommendations
    report.append("## Recommendations")
    recommendations = []
    
    if complexity['complexity_rating'] in ['High', 'Very High']:
        recommendations.append("- Consider breaking this procedure into smaller, more focused procedures")
    
    if complexity['max_nesting_depth'] > 4:
        recommendations.append("- Reduce nesting depth by extracting nested logic into separate procedures")
    
    if complexity['cursor_usage'] > 0:
        recommendations.append("- Review cursor usage and consider set-based alternatives for better performance")
    
    if complexity['dynamic_sql_usage'] > 2:
        recommendations.append("- Review dynamic SQL usage for security and maintainability concerns")
    
    if not structure['has_documentation']:
        recommendations.append("- Add comprehensive comments and documentation")
    
    if len(info['parameters']) > 10:
        recommendations.append("- Consider using table-valued parameters or configuration tables to reduce parameter count")
    
    if not recommendations:
        recommendations.append("- Code structure and complexity appear reasonable")
    
    for rec in recommendations:
        report.append(rec)
    report.append("")
    
    return "\n".join(report)

def main():
    """Main function for command line usage"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Universal SQL stored procedure analyzer')
    parser.add_argument('sql_file', help='Path to SQL file to analyze')
    parser.add_argument('--output', '-o', help='Output file for analysis report')
    parser.add_argument('--format', choices=['markdown', 'json'], default='markdown', help='Output format')
    
    args = parser.parse_args()
    
    # Read SQL file
    try:
        with open(args.sql_file, 'r', encoding='utf-8', errors='ignore') as f:
            sql_content = f.read()
    except FileNotFoundError:
        print(f"Error: File '{args.sql_file}' not found.")
        return
    except Exception as e:
        print(f"Error reading file: {e}")
        return
    
    # Analyze
    analyzer = UniversalSQLAnalyzer()
    result = analyzer.analyze_procedure(sql_content)
    
    # Generate output
    if args.format == 'json':
        # Convert to JSON-serializable format
        json_result = {}
        for key, value in result.items():
            if isinstance(value, list):
                json_result[key] = [item if isinstance(item, dict) else str(item) for item in value]
            else:
                json_result[key] = value
        output = json.dumps(json_result, indent=2)
    else:
        output = generate_universal_analysis_report(result)
    
    # Write output
    if args.output:
        try:
            with open(args.output, 'w', encoding='utf-8') as f:
                f.write(output)
            print(f"Analysis written to {args.output}")
            print(f"Complexity: {result['summary']['complexity_rating']} (Score: {result['summary']['complexity_score']})")
            print(f"Business rules found: {result['summary']['business_rule_count']}")
        except Exception as e:
            print(f"Error writing output file: {e}")
    else:
        print(output)

if __name__ == "__main__":
    main() 