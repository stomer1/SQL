SELECT * FROM tab;
DESC employees;

SELECT * FROM employees;
SELECT * FROM departments;

-- 테이블 내에 정의된 컬럼의 순서대로 
-- 특정 컬럼만 선별적으로 projections
-- 모든 사원의 first_name, 입사일, 급여 출력
SELECT first_name, hire_date, salary
FROM employees;

-- 기본적 산술연산을 수행
-- 산술식 자체가 특정 테이블에  소속된 것이 아닐때 dual
SELECT 10 + 20 FROM dual;
-- 특정 컬럼 값을 수치로 산술계산을 할 수 있다
-- 직원들의 연봉 salay * 12
SELECT first_name,
    salary,
    salary * 12
FROM employees;

--
SELECT first_name, job_id * 12 FROM employees;-- Error
DESC employees; -- job_id는 문자열 -> 산순연산 불가

-- 연습
-- employees 테이블, first_name, phone_number, hire_date, salary를 출력
SELECT first_name, phone_number, hire_date, salary FROM employees;

-- 사원의 first_name, last_name, salary, phone_number, hire_date
SELECT first_name, last_name, salary, phone_number, hire_date FROM employees;

-- 문자열의 연결 ||
-- first_name last_name을 연결 출력
SELECT first_name || ' ' || last_name FROM employees;

SELECT first_name, salary, commission_pct FROM employees;

-- 커미션 포함, 실질 급여를 출력해 봅시다
SELECT first_name, salary, commission_pct, 
salary + salary * commission_pct FROM employees;
-- 중요 : 산술 연산식에 null이 포함되어 있으면 결과 항상 null

-- nvl(expr1, expr2) : expr1이 null이면 expr2 선택
SELECT 
    first_name,
    salary,
    commission_pct,
    salary + salary * nvl(commission_pct, 0)
   FROM employees; 

-- Alias (별칭)
SELECT
    first_name 이름,
    last_name as 성,
    first_name || ' ' || last_name "Full Name" 
    -- 별칭 내에 공백, 특수문자가 포함될 경우 ""로 묶는다
FROM employees;

-- 필드 표시명은 일반적으로 한글 등은 쓰지 말자

--------------------------
--WHERE
--------------------------
-- 조건을 기준으로 레코드 선택(Selection)
-- 급여가 15000이상인 사원의 이름과 연봉
SELECT first_name, salary * 12 "Annual Salary"
FROM employees
WHERE salary >= 15000;

-- 07/01/01 이후 입사한 사원의 이름과 입사일
SELECT first_name, hire_date
FROM employees
WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 사원의 연봉, 입사일, 부서 id
SELECT first_name, salary * 12 "Annual Salary", hire_date, department_id
FROM employees
WHERE first_name = 'Lex';

-- 부서id가 10인 사원의 명단
SELECT * FROM employees
WHERE department_id = 10;

-- 논리 조합
-- 급여가 14000이하 or 17000이상인 사원의 이름과 급여
SELECT first_name, salary
FROM employees
WHERE salary <= 14000 or salary >= 17000;

-- 여집합
SELECT first_name, salary
FROM employees
WHERE NOT (salary <= 14000 or salary >= 17000);

-- 부서 id가 90인 사원 중, 급여가 20000 이상인 사원
SELECT department_id, salary, first_name
FROM employees
WHERE department_id = 90 and salary >= 20000;

SELECT * FROM employees
WHERE department_id = 90 AND salary >= 20000;

-- BETWEEN 연산자
-- 입사일이 07/01/01 ~ 07/12/31 구간의 모든 사원
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';

-- IN 연산자
SELECT * FROM employees
WHERE department_id IN (10, 20, 40);

--manager_id가 100, 120, 147인 사원의 명단
-- 비교연산자 + 논리연산자
SELECT first_name, manager_id
FROM employees
WHERE manager_id = 100 OR
    manager_id = 120 OR
    manager_id = 147;
    
 -- IN 연산자 활용
 SELECT first_name, manager_id
 FROM employees
 WHERE manager_id IN (100, 120, 147);
 
-- LIKE 검색
-- % : 임의의 길이의 지정되지 않은 문자열
-- _ : 한개의 임의의 문자

-- 이름에 am을 포함한 사원의 이름과 급여
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%am%';

-- 이름에 두 번째 글자가 a인 사원의 이름과 급여
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '_a%';

-- 이름에 네 번째 글자가 a인 사원의 이름과 급여
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '___a%';

-- 이름이 4글자인 사원 중, 끝에서 두 글자가 a인 사원
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '___a_';   


--------------

SELECT '            Oracle               '
    '**************Database**************'
 FROM dual;
 
 SELECT LTRIM('            Oracle               '),
    RTRIM('            Oracle              '),
    TRIM('*' FROM '**************Database**************'),
    SUBSTR('Oracle Database', 8, 4),
    SUBSTR('Oracle Database', -8, 4)
FROM dual;
 
 -- 수치형 단일행 함수
SELECT ABS(-3.14), -- 절대값
    CEIL(3.14), -- 소숫점 올림
    FLOOR(3.14), -- 소숫점 버림
    
    MOD(7, 3), -- 나머지
    POWER(2, 4), -- 제곱
    ROUND(3.5), -- 반올림
    ROUND(3.4567, 2), -- 소숫점 2째자리까지 반올림으로 변환
    TRUNC(3.5), -- 소숫점 아래 버림
    TRUNC(3.4567, 2) -- 소숫점 2째자리까지 버림으로 표시
FROM dual;

----------------
-- DATE Format
---------------

-- 날짜 형식 확인
SELECT * FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

-- 현재 날짜와 시간
SELECT sysdate
FROM dual; -- dual 가상 테이블로부터 확인 -> 단일행

SELECT sysdate
FROM employees; -- 테이블로부터 받아오므로 테이블 내 행 갯수만큼을 반환

-- DATE 관련 함수
SELECT sysdate,  -- 현재 날짜와 시간
    ADD_MONTHS(sysdate, 2), -- 2개월 후의 날짜
    MONTHS_BETWEEN('99/12/31', sysdate), --1999년 12월 31일 ~ 현재 달수
    NEXT_DAY(sysdate, 7), -- 현재 날짜 이후의 첫 번째 7요일
    ROUND(TO_DATE('2021-05-17', YYYY-MM-DD'), 'MONTH'), -- MONTH 정보로 반올림
    TRUNC(TO_DATE('2021-05-17', YYYY-MM-DD'), 'MONTH')
FROM dual;

-- 현재 날짜 기준, 입사한지 몇개월 지났는가?
--SELECT first_name, hire_date, 
--(MOTMONTHS_BETWWEN(sysdate, hire_date))

----------------
-- 변환 함수
---------------

--TO_NUMBER(s, frm) :  문자형 -> 수치형
--TO_DATE(s, frm) : 문자형 -> 날짜형
--TO_CHAR(o, fmt) : 숫자, 날짜 -> 문자형

--TO_CHAR
SELECT first_name, hire_date, TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;

--현재 날짜의 포멧
SELECT sysdate, TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT TO_CHAR(123456789.0123, '999,999,999.99')
FROM dual;

-- 연봉 정보를 문자열로 포매팅
SELECT first_name, TO_CHAR(salary * 12, '999,999.99') SAL
FROM employees;

-- TO_NUMBER :  문자열 -> 숫자
SELECT TO_NUMBER('1,999', '999,999'), TO_NUMBER('$1,350.99', '$999,999.99')
FROM dual;

-- TO_DATE : 문자열 -> 날짜
--SELECT TO_DATE('2021-05-05 15:30', YYYY-MM-DD HH24:MI')
--FROM dual;

--Date 연산
--Date +(-) Number : 날짜에 일수 더한다(뺀다) -> Date


SELECT TO_CHAR(sysdate, 'YY/MM/DD HH24:MI'),
    sysdate + 1,
    sysdate - 1,
    sysdate - TO_DATE('2012-09-24', 'YYYY-MM-DD'),
    TO_CHAR(sysdate + 13 / 24, 'YY/MM/DD HH24:MI')
FROM dual;    

-------------------
-- NULL 관련 함수
-------------------

--nvl 함수
SELECT first_name, salary, commission_pct,
    salary + (salary * commission_pct)
FROM employees;


-- nvl2 함수
-- nvl2(표현식, null이 아닐때의 식, null일떄의 식)
SELECT first_name,
    salary,
    commission_pct,
    salary + nvl2(commission_pct, salary * commission_pct, 0)
FROM employees;    

-- case 함수
-- 보너스를 지급하기로 했습니다.
-- AD 관련 직원에게는 20%, SA 관련 직원에게는 10%, IT 관련 직원 8%
-- 나머지에게는 5%의 보너스 지급
SELECT first_name, job_id, salary, SUBSTR(job_id, 1, 2),
    CASE SUBSTR(job_id, 1, 2) WHEN 'AD' THEN salary * 0.2
                                WHEN 'SA' THEN salary *0.1
                                WHEN 'IT' THEN salary*0.08
                                ELSE salary*0.05
    END as bonus                            
FROM employees;

-- Decode
SELECT first_name, Job_id, salary, SUBSTR(job_id, 1, 2),
    DECODE(SUBSTR(job_id, 1, 2),
    'AD', salary * 0.2,
    'SA', salary * 0.1,
    'IT', salary * 0.08,
    salary * 0.05) as bonus
FROM employees;

-- 연습 문제
-- department_id <= 30 -> A-group
-- department_id <= 50 -> B-group
-- department_id <= 100 -> c-group
SELECT first_name, department_id,
    CASE WHEN department_id <= 30 THEN 'A-group'
        WHEN department_id <= 50 THEN 'B-group'
        WHEN department_id <= 100 THEN 'C-group'
        ELSE 'REMAINDER'
    END as team
FROM employees
ORDER BY team;