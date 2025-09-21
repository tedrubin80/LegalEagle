--
-- PostgreSQL database dump
--

\restrict 3zRpxIJdkMh00AoEaE9kwgZXkVjazn1WeYvUk6PiHl2GRmE4QDH8ayROPKj3Mn7

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: legalestate_admin
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO legalestate_admin;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: legalestate_admin
--

COMMENT ON SCHEMA public IS '';


--
-- Name: ActivityType; Type: TYPE; Schema: public; Owner: legalestate_admin
--

CREATE TYPE public."ActivityType" AS ENUM (
    'DOCUMENT_UPLOAD',
    'DOCUMENT_VIEW',
    'DOCUMENT_EDIT',
    'DOCUMENT_DOWNLOAD',
    'DOCUMENT_SHARE',
    'DOCUMENT_REVIEW',
    'EMAIL_SENT',
    'EMAIL_RECEIVED',
    'PHONE_CALL_MADE',
    'PHONE_CALL_RECEIVED',
    'VIDEO_MEETING_CREATED',
    'VIDEO_MEETING_JOINED',
    'VIDEO_MEETING_ENDED',
    'CLIENT_MEETING',
    'CASE_CREATED',
    'CASE_UPDATED',
    'CASE_STATUS_CHANGED',
    'CASE_ASSIGNED',
    'CASE_TRANSFERRED',
    'LEGAL_RESEARCH',
    'DOCUMENT_DRAFTING',
    'CONTRACT_REVIEW',
    'COURT_FILING',
    'DEPOSITION_PREP',
    'MEDICAL_RECORD_REQUEST',
    'MEDICAL_RECORD_RECEIVED',
    'MEDICAL_RECORD_REVIEWED',
    'TASK_CREATED',
    'TASK_COMPLETED',
    'TASK_ASSIGNED',
    'TIME_ENTRY_CREATED',
    'EXPENSE_ADDED',
    'INVOICE_GENERATED',
    'LOGIN',
    'LOGOUT',
    'SYSTEM_ACCESS'
);


ALTER TYPE public."ActivityType" OWNER TO legalestate_admin;

--
-- Name: CasePriority; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CasePriority" AS ENUM (
    'CRITICAL',
    'HIGH',
    'MEDIUM',
    'LOW'
);


ALTER TYPE public."CasePriority" OWNER TO legal_user;

--
-- Name: CaseSource; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CaseSource" AS ENUM (
    'REFERRAL_ATTORNEY',
    'REFERRAL_CLIENT',
    'REFERRAL_FRIEND',
    'ONLINE_SEARCH',
    'ADVERTISEMENT',
    'SOCIAL_MEDIA',
    'YELLOW_PAGES',
    'DIRECT_MAIL',
    'WALK_IN',
    'RETURN_CLIENT',
    'OTHER'
);


ALTER TYPE public."CaseSource" OWNER TO legal_user;

--
-- Name: CaseStage; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CaseStage" AS ENUM (
    'PRE_LITIGATION',
    'LITIGATION',
    'SETTLEMENT',
    'TRIAL',
    'POST_JUDGMENT',
    'APPEAL',
    'CLOSED'
);


ALTER TYPE public."CaseStage" OWNER TO legal_user;

--
-- Name: CaseStatus; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CaseStatus" AS ENUM (
    'INTAKE',
    'CONSULTATION_SCHEDULED',
    'CONSULTATION_COMPLETED',
    'RETAINER_SIGNED',
    'INVESTIGATION',
    'DISCOVERY',
    'ACTIVE',
    'SETTLEMENT_NEGOTIATION',
    'MEDIATION',
    'ARBITRATION',
    'LITIGATION',
    'TRIAL_PREPARATION',
    'TRIAL',
    'POST_TRIAL',
    'SETTLED',
    'DISMISSED',
    'CLOSED',
    'ARCHIVED',
    'ON_HOLD',
    'REFERRED_OUT'
);


ALTER TYPE public."CaseStatus" OWNER TO legal_user;

--
-- Name: CaseType; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CaseType" AS ENUM (
    'PERSONAL_INJURY',
    'AUTO_ACCIDENT',
    'MEDICAL_MALPRACTICE',
    'WORKERS_COMP',
    'PREMISES_LIABILITY',
    'PRODUCT_LIABILITY',
    'CONTRACT_DISPUTE',
    'EMPLOYMENT_LAW',
    'FAMILY_LAW',
    'CRIMINAL_DEFENSE',
    'ESTATE_PLANNING',
    'REAL_ESTATE',
    'BANKRUPTCY',
    'BUSINESS_LAW',
    'IMMIGRATION'
);


ALTER TYPE public."CaseType" OWNER TO legal_user;

--
-- Name: CommunicationDirection; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CommunicationDirection" AS ENUM (
    'INBOUND',
    'OUTBOUND'
);


ALTER TYPE public."CommunicationDirection" OWNER TO legal_user;

--
-- Name: CommunicationStatus; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CommunicationStatus" AS ENUM (
    'DRAFT',
    'SENT',
    'DELIVERED',
    'READ',
    'REPLIED',
    'FAILED',
    'SCHEDULED'
);


ALTER TYPE public."CommunicationStatus" OWNER TO legal_user;

--
-- Name: CommunicationType; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."CommunicationType" AS ENUM (
    'EMAIL',
    'PHONE',
    'TEXT',
    'MEETING',
    'LETTER',
    'VIDEO_CALL',
    'VOICEMAIL',
    'FAX',
    'DOCUMENT_DELIVERY'
);


ALTER TYPE public."CommunicationType" OWNER TO legal_user;

--
-- Name: ContactMethod; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."ContactMethod" AS ENUM (
    'EMAIL',
    'PHONE',
    'TEXT',
    'MAIL',
    'IN_PERSON'
);


ALTER TYPE public."ContactMethod" OWNER TO legal_user;

--
-- Name: DocumentType; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."DocumentType" AS ENUM (
    'CONTRACT',
    'MEDICAL_RECORD',
    'POLICE_REPORT',
    'INSURANCE_DOCUMENT',
    'PHOTO_EVIDENCE',
    'CORRESPONDENCE',
    'LEGAL_BRIEF',
    'DEMAND_LETTER',
    'SETTLEMENT_AGREEMENT',
    'DISCOVERY_REQUEST',
    'RETAINER_AGREEMENT',
    'INVOICE',
    'RECEIPT',
    'WITNESS_STATEMENT',
    'EXPERT_REPORT',
    'COURT_FILING',
    'OTHER'
);


ALTER TYPE public."DocumentType" OWNER TO legal_user;

--
-- Name: EventType; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."EventType" AS ENUM (
    'COURT_DATE',
    'DEPOSITION',
    'MEDIATION',
    'ARBITRATION',
    'SETTLEMENT_CONFERENCE',
    'CLIENT_MEETING',
    'DEADLINE',
    'STATUTE_DEADLINE',
    'DISCOVERY_DEADLINE',
    'TRIAL_DATE',
    'APPEAL_DEADLINE',
    'CONSULTATION',
    'FOLLOW_UP'
);


ALTER TYPE public."EventType" OWNER TO legal_user;

--
-- Name: InvoiceStatus; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."InvoiceStatus" AS ENUM (
    'DRAFT',
    'SENT',
    'PAID',
    'OVERDUE',
    'CANCELLED',
    'PARTIAL_PAYMENT'
);


ALTER TYPE public."InvoiceStatus" OWNER TO legal_user;

--
-- Name: MaritalStatus; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."MaritalStatus" AS ENUM (
    'SINGLE',
    'MARRIED',
    'DIVORCED',
    'WIDOWED',
    'SEPARATED',
    'DOMESTIC_PARTNER'
);


ALTER TYPE public."MaritalStatus" OWNER TO legal_user;

--
-- Name: SettlementStatus; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."SettlementStatus" AS ENUM (
    'DRAFT',
    'PROPOSED',
    'NEGOTIATING',
    'ACCEPTED',
    'REJECTED',
    'EXECUTED',
    'PAID',
    'CANCELLED'
);


ALTER TYPE public."SettlementStatus" OWNER TO legal_user;

--
-- Name: TaskTemplate; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."TaskTemplate" AS ENUM (
    'INITIAL_CONSULTATION',
    'RETAINER_AGREEMENT',
    'MEDICAL_RECORDS_REQUEST',
    'DEMAND_LETTER',
    'SETTLEMENT_NEGOTIATION',
    'TRIAL_PREPARATION',
    'DOCUMENT_REVIEW',
    'CLIENT_UPDATE'
);


ALTER TYPE public."TaskTemplate" OWNER TO legal_user;

--
-- Name: TemplateType; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."TemplateType" AS ENUM (
    'CASE_WORKFLOW',
    'DOCUMENT_CHECKLIST',
    'TASK_LIST',
    'COMMUNICATION_TEMPLATE',
    'SETTLEMENT_TEMPLATE'
);


ALTER TYPE public."TemplateType" OWNER TO legal_user;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: legal_user
--

CREATE TYPE public."UserRole" AS ENUM (
    'ADMIN',
    'ATTORNEY',
    'PARALEGAL',
    'ASSISTANT',
    'CLIENT',
    'SUPER_ADMIN'
);


ALTER TYPE public."UserRole" OWNER TO legal_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Activity; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."Activity" (
    id text NOT NULL,
    action text NOT NULL,
    description text NOT NULL,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "userId" text NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Activity" OWNER TO legal_user;

--
-- Name: AiProviderConfig; Type: TABLE; Schema: public; Owner: legalestate_admin
--

CREATE TABLE public."AiProviderConfig" (
    id text NOT NULL,
    provider character varying(50) NOT NULL,
    "apiKey" text,
    model character varying(100),
    enabled boolean DEFAULT false NOT NULL,
    "lastTested" timestamp(6) with time zone,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."AiProviderConfig" OWNER TO legalestate_admin;

--
-- Name: CaseActivity; Type: TABLE; Schema: public; Owner: legalestate_admin
--

CREATE TABLE public."CaseActivity" (
    id text NOT NULL,
    "caseId" text NOT NULL,
    "userId" text NOT NULL,
    "activityType" text NOT NULL,
    action text NOT NULL,
    description text,
    "startTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endTime" timestamp(3) without time zone,
    duration integer,
    "isBillable" boolean DEFAULT true NOT NULL,
    "hourlyRate" numeric(10,2),
    "billingAmount" numeric(10,2),
    "entityType" text,
    "entityId" text,
    metadata jsonb,
    "ipAddress" text,
    "userAgent" text,
    tags text[],
    "isSystemGenerated" boolean DEFAULT false NOT NULL,
    "parentActivityId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CaseActivity" OWNER TO legalestate_admin;

--
-- Name: Document; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."Document" (
    id text NOT NULL,
    title text NOT NULL,
    filename text,
    "originalName" text,
    "fileType" text,
    "fileSize" integer,
    "filePath" text,
    type public."DocumentType" DEFAULT 'OTHER'::public."DocumentType" NOT NULL,
    content text,
    description text,
    "caseId" text,
    "clientId" text,
    "uploadedBy" text NOT NULL,
    "generatedBy" text,
    "aiProvider" text,
    metadata jsonb,
    version integer DEFAULT 1 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "lastActivity" timestamp(3) without time zone,
    "activityCount" integer DEFAULT 0,
    "averageResponseTime" double precision,
    collaborators text[],
    "viewCount" integer DEFAULT 0,
    "lastViewed" timestamp with time zone,
    "lastViewedBy" text,
    "downloadCount" integer DEFAULT 0,
    "lastDownload" timestamp with time zone
);


ALTER TABLE public."Document" OWNER TO legal_user;

--
-- Name: Expense; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."Expense" (
    id text NOT NULL,
    description text NOT NULL,
    amount numeric(65,30) NOT NULL,
    category text NOT NULL,
    date timestamp(3) without time zone NOT NULL,
    receipt text,
    reimbursable boolean DEFAULT true NOT NULL,
    reimbursed boolean DEFAULT false NOT NULL,
    "caseId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Expense" OWNER TO legal_user;

--
-- Name: Insurance; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."Insurance" (
    id text NOT NULL,
    "caseId" text NOT NULL,
    company text NOT NULL,
    "policyNumber" text,
    "adjusterName" text,
    "adjusterPhone" text,
    "adjusterEmail" text,
    "policyLimits" text,
    type text NOT NULL,
    "isOwnInsurance" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Insurance" OWNER TO legal_user;

--
-- Name: MedicalProvider; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."MedicalProvider" (
    id text NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    address text,
    phone text,
    fax text,
    email text,
    "contactPerson" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."MedicalProvider" OWNER TO legal_user;

--
-- Name: MedicalRecord; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."MedicalRecord" (
    id text NOT NULL,
    "caseId" text NOT NULL,
    "providerId" text NOT NULL,
    "dateOfService" timestamp(3) without time zone NOT NULL,
    "typeOfService" text NOT NULL,
    description text,
    cost numeric(65,30),
    requested boolean DEFAULT false NOT NULL,
    received boolean DEFAULT false NOT NULL,
    "dateRequested" timestamp(3) without time zone,
    "dateReceived" timestamp(3) without time zone,
    "documentUrl" text,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."MedicalRecord" OWNER TO legal_user;

--
-- Name: Note; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."Note" (
    id text NOT NULL,
    content text NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "caseId" text,
    "createdById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Note" OWNER TO legal_user;

--
-- Name: Task; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."Task" (
    id text NOT NULL,
    title text NOT NULL,
    description text,
    "dueDate" timestamp(3) without time zone,
    priority text DEFAULT 'MEDIUM'::text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "caseId" text,
    "clientId" text,
    "assignedToId" text NOT NULL,
    "createdById" text NOT NULL,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Task" OWNER TO legal_user;

--
-- Name: TimeEntry; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."TimeEntry" (
    id text NOT NULL,
    description text NOT NULL,
    hours numeric(65,30) NOT NULL,
    rate numeric(65,30) NOT NULL,
    amount numeric(65,30) NOT NULL,
    date timestamp(3) without time zone NOT NULL,
    billable boolean DEFAULT true NOT NULL,
    billed boolean DEFAULT false NOT NULL,
    "caseId" text,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isAutoTracked" boolean DEFAULT false,
    "activityType" text,
    "sourceType" text,
    "sourceId" text,
    metadata jsonb
);


ALTER TABLE public."TimeEntry" OWNER TO legal_user;

--
-- Name: User; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."User" (
    id text NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    name character varying(255) NOT NULL,
    "firstName" character varying(100),
    "lastName" character varying(100),
    role public."UserRole" DEFAULT 'PARALEGAL'::public."UserRole" NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    phone character varying(20),
    address text,
    "barNumber" character varying(50),
    signature character varying(500),
    "hourlyRate" numeric(8,2),
    "emailVerified" boolean DEFAULT false NOT NULL,
    "emailVerificationToken" character varying(255),
    "passwordResetToken" character varying(255),
    "passwordResetExpires" timestamp(6) with time zone,
    "loginAttempts" integer DEFAULT 0 NOT NULL,
    "lockedUntil" timestamp(6) with time zone,
    "twoFactorSecret" character varying(255),
    "twoFactorEnabled" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL,
    "lastLogin" timestamp(6) with time zone
);


ALTER TABLE public."User" OWNER TO legal_user;

--
-- Name: _CaseToMedicalProvider; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public."_CaseToMedicalProvider" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_CaseToMedicalProvider" OWNER TO legal_user;

--
-- Name: calendar_events; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.calendar_events (
    id text NOT NULL,
    title character varying(500) NOT NULL,
    description text,
    type public."EventType" NOT NULL,
    "startDate" date NOT NULL,
    "endDate" date,
    "startTime" character varying(20),
    "endTime" character varying(20),
    "allDay" boolean DEFAULT false NOT NULL,
    location character varying(500),
    "caseId" text,
    "clientId" text,
    "createdById" text NOT NULL,
    "assignedToId" text,
    attendees jsonb,
    "judgeId" text,
    courtroom character varying(50),
    "caseNumber" character varying(50),
    "reminderSent" boolean DEFAULT false NOT NULL,
    "reminderTime" integer,
    completed boolean DEFAULT false NOT NULL,
    cancelled boolean DEFAULT false NOT NULL,
    rescheduled boolean DEFAULT false NOT NULL,
    "originalEventId" text,
    "isRecurring" boolean DEFAULT false NOT NULL,
    "recurringRule" jsonb,
    "parentEventId" text,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.calendar_events OWNER TO legal_user;

--
-- Name: case_deadlines; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.case_deadlines (
    id text NOT NULL,
    "caseId" text NOT NULL,
    title character varying(300) NOT NULL,
    description text,
    "dueDate" date NOT NULL,
    type character varying(100) NOT NULL,
    priority public."CasePriority" DEFAULT 'MEDIUM'::public."CasePriority" NOT NULL,
    "isStatutory" boolean DEFAULT false NOT NULL,
    "reminderDays" integer[] DEFAULT ARRAY[7, 1],
    completed boolean DEFAULT false NOT NULL,
    "completedAt" timestamp(6) with time zone,
    "completedById" text
);


ALTER TABLE public.case_deadlines OWNER TO legal_user;

--
-- Name: case_status_history; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.case_status_history (
    id text NOT NULL,
    "caseId" text NOT NULL,
    "fromStatus" public."CaseStatus",
    "toStatus" public."CaseStatus" NOT NULL,
    "changedAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "changedById" text NOT NULL,
    reason character varying(500),
    notes text
);


ALTER TABLE public.case_status_history OWNER TO legal_user;

--
-- Name: case_template_tasks; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.case_template_tasks (
    id text NOT NULL,
    "templateId" text NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    "taskType" public."TaskTemplate" NOT NULL,
    priority text DEFAULT 'MEDIUM'::text NOT NULL,
    "estimatedHours" numeric(5,2),
    "dueDaysFromStart" integer,
    "dueDaysFromStep" text,
    "assignToRole" public."UserRole",
    "assignToField" text,
    "prerequisiteTasks" jsonb,
    "templateOrder" integer DEFAULT 0 NOT NULL,
    "isRequired" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.case_template_tasks OWNER TO legal_user;

--
-- Name: case_templates; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.case_templates (
    id text NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    "caseType" public."CaseType" NOT NULL,
    "templateType" public."TemplateType" NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "isDefault" boolean DEFAULT false NOT NULL,
    "defaultStatus" public."CaseStatus" DEFAULT 'INTAKE'::public."CaseStatus" NOT NULL,
    "defaultPriority" public."CasePriority" DEFAULT 'MEDIUM'::public."CasePriority" NOT NULL,
    "defaultStage" public."CaseStage" DEFAULT 'PRE_LITIGATION'::public."CaseStage" NOT NULL,
    "workflowSteps" jsonb,
    "taskTemplates" jsonb,
    "deadlineTemplates" jsonb,
    "documentTemplates" jsonb,
    "communicationTemplates" jsonb,
    "createdById" text NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.case_templates OWNER TO legal_user;

--
-- Name: case_values; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.case_values (
    id text NOT NULL,
    "caseId" text NOT NULL,
    "valueType" character varying(50) NOT NULL,
    amount numeric(12,2) NOT NULL,
    description character varying(500),
    date date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "enteredById" text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL
);


ALTER TABLE public.case_values OWNER TO legal_user;

--
-- Name: case_workflow_steps; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.case_workflow_steps (
    id text NOT NULL,
    "templateId" text,
    "caseId" text,
    name character varying(200) NOT NULL,
    description text,
    "stepOrder" integer NOT NULL,
    "estimatedDays" integer,
    "prerequisiteSteps" jsonb,
    "autoCreateTasks" boolean DEFAULT false NOT NULL,
    "autoCreateDeadlines" boolean DEFAULT false NOT NULL,
    "autoCreateDocuments" boolean DEFAULT false NOT NULL,
    "taskTemplate" public."TaskTemplate",
    "taskTitle" character varying(200),
    "taskDescription" text,
    "taskDueDays" integer,
    "isCompleted" boolean DEFAULT false NOT NULL,
    "completedAt" timestamp(6) with time zone,
    "completedById" text,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.case_workflow_steps OWNER TO legal_user;

--
-- Name: cases; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.cases (
    id text NOT NULL,
    "caseNumber" character varying(50) NOT NULL,
    title character varying(500) NOT NULL,
    description text,
    type public."CaseType" NOT NULL,
    status public."CaseStatus" DEFAULT 'INTAKE'::public."CaseStatus" NOT NULL,
    priority public."CasePriority" DEFAULT 'MEDIUM'::public."CasePriority" NOT NULL,
    stage public."CaseStage" DEFAULT 'PRE_LITIGATION'::public."CaseStage" NOT NULL,
    source public."CaseSource",
    "dateOpened" date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "consultationDate" date,
    "retainerSignedDate" date,
    "discoveryStartDate" date,
    "discoveryEndDate" date,
    "mediationDate" date,
    "trialDate" date,
    "settlementDate" date,
    "dateClosed" date,
    statute date,
    "nextDeadline" date,
    "deadlineDescription" character varying(500),
    "clientId" text NOT NULL,
    "attorneyId" text,
    "paralegalId" text,
    "secondAttorneyId" text,
    "referringAttorneyId" text,
    "estimatedValue" numeric(12,2),
    "demandAmount" numeric(12,2),
    "settlementAmount" numeric(12,2),
    "attorneyFees" numeric(12,2),
    costs numeric(12,2),
    "netToClient" numeric(12,2),
    "contingencyRate" numeric(5,2),
    "hoursWorked" numeric(8,2) DEFAULT 0,
    "totalBilled" numeric(12,2) DEFAULT 0,
    "costsIncurred" numeric(12,2) DEFAULT 0,
    "isActive" boolean DEFAULT true NOT NULL,
    "isArchived" boolean DEFAULT false NOT NULL,
    "internalNotes" text,
    "clientInstructions" text,
    "workflowTemplate" character varying(100),
    "customFields" jsonb,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.cases OWNER TO legal_user;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.clients (
    id text NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100) NOT NULL,
    email character varying(255),
    phone character varying(20),
    address character varying(500),
    city character varying(100),
    state character varying(2),
    "zipCode" character varying(10),
    "dateOfBirth" date,
    ssn character varying(11),
    "emergencyContact" character varying(255),
    "emergencyPhone" character varying(20),
    notes text,
    source character varying(100),
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL,
    "createdById" text NOT NULL,
    mobile character varying(20),
    "workPhone" character varying(20),
    employer character varying(200),
    occupation character varying(100),
    "maritalStatus" public."MaritalStatus" DEFAULT 'SINGLE'::public."MaritalStatus" NOT NULL,
    "spouseName" character varying(200),
    "preferredContact" public."ContactMethod" DEFAULT 'EMAIL'::public."ContactMethod" NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "clientNumber" character varying(20)
);


ALTER TABLE public.clients OWNER TO legal_user;

--
-- Name: communication_attachments; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.communication_attachments (
    id text NOT NULL,
    "fileName" character varying(255) NOT NULL,
    "originalName" character varying(255) NOT NULL,
    "mimeType" character varying(100) NOT NULL,
    "fileSize" integer NOT NULL,
    "filePath" character varying(500) NOT NULL,
    "isConfidential" boolean DEFAULT false NOT NULL,
    "communicationId" text NOT NULL,
    "uploadedBy" text NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.communication_attachments OWNER TO legal_user;

--
-- Name: communications; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.communications (
    id text NOT NULL,
    type public."CommunicationType" NOT NULL,
    direction public."CommunicationDirection" NOT NULL,
    status public."CommunicationStatus" DEFAULT 'SENT'::public."CommunicationStatus" NOT NULL,
    subject character varying(500),
    content text,
    summary character varying(1000),
    "dateTime" timestamp(3) without time zone NOT NULL,
    duration integer,
    "followUpRequired" boolean DEFAULT false NOT NULL,
    "followUpDate" timestamp(3) without time zone,
    priority text DEFAULT 'NORMAL'::text,
    "fromEmail" character varying(255),
    "toEmails" text[],
    "fromPhone" character varying(20),
    "toPhone" character varying(20),
    "attachmentCount" integer DEFAULT 0 NOT NULL,
    "isConfidential" boolean DEFAULT false NOT NULL,
    billable boolean DEFAULT true NOT NULL,
    "billingNotes" character varying(500),
    "caseId" text,
    "clientId" text,
    "userId" text NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.communications OWNER TO legal_user;

--
-- Name: emergency_contacts; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.emergency_contacts (
    id text NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100) NOT NULL,
    relationship character varying(100) NOT NULL,
    phone character varying(20),
    email character varying(255),
    address character varying(500),
    "isPrimary" boolean DEFAULT false NOT NULL,
    "clientId" text NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.emergency_contacts OWNER TO legal_user;

--
-- Name: incidents; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.incidents (
    id text NOT NULL,
    "caseId" text NOT NULL,
    "dateOfIncident" date NOT NULL,
    "timeOfIncident" character varying(20),
    location character varying(500) NOT NULL,
    description text NOT NULL,
    "policeReport" character varying(10),
    "policeReportNum" character varying(100),
    "weatherConditions" character varying(200),
    witnesses jsonb,
    photos character varying(500)[],
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.incidents OWNER TO legal_user;

--
-- Name: invoice_line_items; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.invoice_line_items (
    id text NOT NULL,
    "invoiceId" text NOT NULL,
    description character varying(500) NOT NULL,
    quantity numeric(10,4) DEFAULT 1 NOT NULL,
    rate numeric(10,2) NOT NULL,
    amount numeric(12,2) NOT NULL,
    "timeEntryId" text,
    "expenseId" text,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.invoice_line_items OWNER TO legal_user;

--
-- Name: invoices; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.invoices (
    id text NOT NULL,
    "invoiceNumber" character varying(50) NOT NULL,
    "clientId" text,
    "caseId" text,
    "issueDate" date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "dueDate" date NOT NULL,
    "paidDate" date,
    status public."InvoiceStatus" DEFAULT 'DRAFT'::public."InvoiceStatus" NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    "taxRate" numeric(5,4) DEFAULT 0,
    "taxAmount" numeric(12,2) DEFAULT 0,
    "totalAmount" numeric(12,2) NOT NULL,
    "paidAmount" numeric(12,2) DEFAULT 0,
    "balanceDue" numeric(12,2),
    "paymentMethod" character varying(100),
    "paymentReference" character varying(255),
    description text,
    notes text,
    terms text,
    "createdById" text NOT NULL,
    "sentToClient" boolean DEFAULT false NOT NULL,
    "sentDate" timestamp(6) with time zone,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.invoices OWNER TO legal_user;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.notifications (
    id text NOT NULL,
    type character varying(50) NOT NULL,
    title character varying(200) NOT NULL,
    message text NOT NULL,
    "userId" text NOT NULL,
    "entityType" character varying(50),
    "entityId" text,
    "isRead" boolean DEFAULT false NOT NULL,
    "readAt" timestamp(6) with time zone,
    "scheduledFor" timestamp(6) with time zone,
    status text DEFAULT 'PENDING'::text NOT NULL,
    metadata jsonb,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.notifications OWNER TO legal_user;

--
-- Name: settlements; Type: TABLE; Schema: public; Owner: legal_user
--

CREATE TABLE public.settlements (
    id text NOT NULL,
    "caseId" text NOT NULL,
    amount numeric(12,2) NOT NULL,
    status public."SettlementStatus" DEFAULT 'DRAFT'::public."SettlementStatus" NOT NULL,
    "proposedDate" date,
    "acceptedDate" date,
    "executedDate" date,
    "paidDate" date,
    "attorneyFees" numeric(12,2),
    costs numeric(12,2),
    "netToClient" numeric(12,2),
    "attorneyPercent" numeric(5,2),
    "paymentTerms" text,
    "paymentSchedule" jsonb,
    settlor character varying(255),
    "payorContact" character varying(255),
    "payorPhone" character varying(20),
    "payorEmail" character varying(255),
    description text,
    conditions text,
    confidential boolean DEFAULT false NOT NULL,
    releases jsonb,
    "demandLetterSent" boolean DEFAULT false NOT NULL,
    "agreementSigned" boolean DEFAULT false NOT NULL,
    "releasesSigned" boolean DEFAULT false NOT NULL,
    "negotiatedById" text NOT NULL,
    "approvedById" text,
    "createdAt" timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.settlements OWNER TO legal_user;

--
-- Data for Name: Activity; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."Activity" (id, action, description, "entityType", "entityId", "userId", "ipAddress", "userAgent", "createdAt") FROM stdin;
df1b1580c5e1e90053704d3b9cf63092	CLIENT_CREATED	New client created: John Doe	CLIENT	cmevqt13e0001md3m8v7svvbo	test-user-id	::ffff:127.0.0.1	\N	2025-08-28 18:33:58.736
308ed7b2efe1afc979cd4513355c2e6a	CASE_CREATED	Case created: CS20250001 - Personal Injury Case - Car Accident on I-95	CASE	cmevqt14a0003md3mor8yopoo	test-user-id	::ffff:127.0.0.1	\N	2025-08-28 18:33:58.771
cmezvm58n000339iadinw6j6p	CREATE	Created client: Test Client	CLIENT	cmezvm58d000139iauozlch2e	cmexiqs420000l5dhtoudak11	127.0.0.1	curl/8.5.0	2025-08-31 15:59:40.295
cmezvqurm000739iaynqr1bzt	CREATE	Created client: E2E Test	CLIENT	cmezvqurg000539iab6hf2sd0	cmexiqs420000l5dhtoudak11	127.0.0.1	curl/8.5.0	2025-08-31 16:03:20.002
cmezvrara000b39iaj0m41975	CREATE	Created client: Final Test	CLIENT	cmezvrar5000939ia801zcaxl	cmexiqs420000l5dhtoudak11	127.0.0.1	curl/8.5.0	2025-08-31 16:03:40.726
0dce0cf14aab2f8f5f6e5ee362cd6fee	PASSWORD_RESET_REQUEST	Password reset requested for admin@example.com	USER	cmexiqs420000l5dhtoudak11	cmexiqs420000l5dhtoudak11	127.0.0.1	curl/8.5.0	2025-08-31 16:09:53.067
cmezyogiz000411hv76uwcw8j	CREATE	Created client: John Smith	CLIENT	cmezyogiq000211hvlzpuon77	cmezy68ks000011hv1bcrzwal	178.156.138.135	curl/8.5.0	2025-08-31 17:25:27.084
32c08aff72bfcc3b50973f62808501ff	PASSWORD_RESET_REQUEST	Password reset requested for test@admin.com	USER	cmezy68ks000011hv1bcrzwal	cmezy68ks000011hv1bcrzwal	178.156.138.135	curl/8.5.0	2025-08-31 17:47:56.766
2da3041a31d2553bbf51a632ef0771e1	PASSWORD_RESET_REQUEST	Password reset requested for test@admin.com	USER	cmezy68ks000011hv1bcrzwal	cmezy68ks000011hv1bcrzwal	178.156.138.135	curl/8.5.0	2025-08-31 18:08:16.661
0c989c413c90988fac3913d0b2dfac94	PASSWORD_RESET_REQUEST	Password reset requested for test@admin.com	USER	cmezy68ks000011hv1bcrzwal	cmezy68ks000011hv1bcrzwal	178.156.138.135	curl/8.5.0	2025-08-31 18:10:05.975
cmf7470j20001j2c3kfjh16gh	Legal Research	Conducted comprehensive legal research	CASE	test-case-123	cmf639l450000k7e5xwbydd9t	127.0.0.1	curl/8.5.0	2025-09-05 17:34:14.125
cmf74b35z0001491h2uubokyn	Document Drafting	Drafted legal document	CASE	test-case-456	cmf639l450000k7e5xwbydd9t	127.0.0.1	curl/8.5.0	2025-09-05 17:37:24.166
cmf74cl3y0005491h7ft4n6lt	Client Meeting	Conducted client consultation meeting	CASE	cmevqt14a0003md3mor8yopoo	cmf639l450000k7e5xwbydd9t	127.0.0.1	curl/8.5.0	2025-09-05 17:38:34.078
cmf74gazy000110jy8kopx0md	Court Filing	Prepared and filed court documents	CASE	cmevqt14a0003md3mor8yopoo	cmf639l450000k7e5xwbydd9t	127.0.0.1	curl/8.5.0	2025-09-05 17:41:27.597
cmf797yvx00037j5n28g0rrlt	CREATE	Created client: Ted Rubin	CLIENT	cmf797yvh00017j5nxr7aaz72	ce7cadbe0f01fcdc79a0138a826d5969	104.28.132.121	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Safari/605.1.15	2025-09-05 19:54:56.734
3a327df962a3e8f6bc0424824148e8af	CLIENT_CREATED	New client created: Jane Smith	CLIENT	cmfeqwzss0005l55mj3tsl5wo	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:41.029
75b7ffb5ec1ec36a4f3b3d110dcc40dc	CLIENT_UPDATED	Client updated: Updated Jane Smith	CLIENT	cmfeqwzss0005l55mj3tsl5wo	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:41.211
0e3299676f1bf109a863c5dda749cf0d	CLIENT_CREATED	New client created: Test Error	CLIENT	cmfeqwzzu0007l55moytz4mph	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:41.279
55437b943ac1394889c37153ecd4176c	CLIENT_CREATED	New client created: John Doe	CLIENT	cmfeqx1qh0009l55myst3e0jo	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:43.54
52f6da37c7128616ddbf68c5e4ce14c9	COMMUNICATION_CREATED	Communication logged: EMAIL OUTBOUND - Case Status Update	COMMUNICATION	cmfeqx1s9000bl55mi7ix2txt	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:43.612
9753bb75881a2c0a5f020e13268a857d	COMMUNICATION_CREATED	Communication logged: PHONE INBOUND - No subject	COMMUNICATION	cmfeqx229000dl55m20pg6dzv	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:43.961
fc88b02ae7a17f1fec541a4e4b2ee357	COMMUNICATION_CREATED	Communication logged: MEETING OUTBOUND - Initial client consultation	COMMUNICATION	cmfeqx22t000fl55m56awhuuz	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:43.978
ef08c1919cb39722cf81f73722e8afa6	CLIENT_CREATED	New client created: John Doe	CLIENT	cmfeqx9g0000ll55mdo7ch2sx	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 01:44:53.527
d5bd7b2e6d7c5db1dd703e0220ffd846	REGISTER	New user registered: test.user@example.com	USER	cmfeqxbng000ml55mfna3izs7	cmfeqxbng000ml55mfna3izs7	::ffff:127.0.0.1	Unknown	2025-09-11 01:44:56.386
6f276e9a5dc5a1a1e26e71c96774cb6b	LOGIN	User logged in from ::ffff:127.0.0.1	USER	cmfeqxbng000ml55mfna3izs7	cmfeqxbng000ml55mfna3izs7	::ffff:127.0.0.1	Unknown	2025-09-11 01:44:56.918
a5e8b73216c807221921007eb3bcf7c7	PASSWORD_RESET_REQUEST	Password reset requested for test.user@example.com	USER	cmfeqxbng000ml55mfna3izs7	cmfeqxbng000ml55mfna3izs7	::ffff:127.0.0.1	Unknown	2025-09-11 01:44:57.445
6e8a72f6345fc689f4aec96c114caca5	LOGIN	User logged in from ::ffff:127.0.0.1	USER	cmfeqxbng000ml55mfna3izs7	cmfeqxbng000ml55mfna3izs7	::ffff:127.0.0.1	Unknown	2025-09-11 14:16:16.917
dfc9b122e7fe67eadb2d35686a7f96cc	PASSWORD_RESET_REQUEST	Password reset requested for test.user@example.com	USER	cmfeqxbng000ml55mfna3izs7	cmfeqxbng000ml55mfna3izs7	::ffff:127.0.0.1	Unknown	2025-09-11 14:16:17.43
47d03757f751171cd2006439fd5286ae	CLIENT_CREATED	New client created: John Doe	CLIENT	cmffhrso80009lcbtzr1l94pe	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:28.143
9040cede8fd06d63187831e4f7340d20	COMMUNICATION_CREATED	Communication logged: EMAIL OUTBOUND - Case Status Update	COMMUNICATION	cmffhrsph000blcbtmtav0654	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:28.19
b6d96ded98c0b0d6d20c852619457533	COMMUNICATION_CREATED	Communication logged: PHONE INBOUND - No subject	COMMUNICATION	cmffhrt0y000dlcbtkpoerxw3	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:28.601
f0f45b62b06883e9973ac8376adade7c	COMMUNICATION_CREATED	Communication logged: MEETING OUTBOUND - Initial client consultation	COMMUNICATION	cmffhrt1d000flcbtmkce4t1w	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:28.613
d52b5db723ad00712d7b4cc9d147d8fd	CLIENT_CREATED	New client created: John Doe	CLIENT	cmffhrw69000hlcbt1hyvhyqx	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:32.682
56757af6743937252f462b449cea6cb5	CLIENT_CREATED	New client created: Jane Smith	CLIENT	cmffhrzhp000jlcbte4xi9icw	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:36.983
3fb259ca7c157689adda2732d3a631bf	CLIENT_UPDATED	Client updated: Updated Jane Smith	CLIENT	cmffhrzhp000jlcbte4xi9icw	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:37.122
c4ea1a14b9e375e5a9c02cc9675af937	CLIENT_CREATED	New client created: Test Error	CLIENT	cmffhrzn7000llcbtpml0q8v9	test-user-id	::ffff:127.0.0.1	\N	2025-09-11 14:16:37.175
\.


--
-- Data for Name: AiProviderConfig; Type: TABLE DATA; Schema: public; Owner: legalestate_admin
--

COPY public."AiProviderConfig" (id, provider, "apiKey", model, enabled, "lastTested", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: CaseActivity; Type: TABLE DATA; Schema: public; Owner: legalestate_admin
--

COPY public."CaseActivity" (id, "caseId", "userId", "activityType", action, description, "startTime", "endTime", duration, "isBillable", "hourlyRate", "billingAmount", "entityType", "entityId", metadata, "ipAddress", "userAgent", tags, "isSystemGenerated", "parentActivityId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Document; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."Document" (id, title, filename, "originalName", "fileType", "fileSize", "filePath", type, content, description, "caseId", "clientId", "uploadedBy", "generatedBy", "aiProvider", metadata, version, "isActive", "createdAt", "updatedAt", "lastActivity", "activityCount", "averageResponseTime", collaborators, "viewCount", "lastViewed", "lastViewedBy", "downloadCount", "lastDownload") FROM stdin;
\.


--
-- Data for Name: Expense; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."Expense" (id, description, amount, category, date, receipt, reimbursable, reimbursed, "caseId", "createdAt") FROM stdin;
\.


--
-- Data for Name: Insurance; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."Insurance" (id, "caseId", company, "policyNumber", "adjusterName", "adjusterPhone", "adjusterEmail", "policyLimits", type, "isOwnInsurance", "createdAt") FROM stdin;
\.


--
-- Data for Name: MedicalProvider; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."MedicalProvider" (id, name, type, address, phone, fax, email, "contactPerson", "createdAt") FROM stdin;
\.


--
-- Data for Name: MedicalRecord; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."MedicalRecord" (id, "caseId", "providerId", "dateOfService", "typeOfService", description, cost, requested, received, "dateRequested", "dateReceived", "documentUrl", notes, "createdAt") FROM stdin;
\.


--
-- Data for Name: Note; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."Note" (id, content, "isPrivate", "caseId", "createdById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Task; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."Task" (id, title, description, "dueDate", priority, status, "caseId", "clientId", "assignedToId", "createdById", "completedAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: TimeEntry; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."TimeEntry" (id, description, hours, rate, amount, date, billable, billed, "caseId", "userId", "createdAt", "isAutoTracked", "activityType", "sourceType", "sourceId", metadata) FROM stdin;
cmf74cl410007491hdedelade	[AUTO] Conducted client consultation meeting	2.000000000000000000000000000000	150.000000000000000000000000000000	300.000000000000000000000000000000	2025-09-05 17:38:34.08	t	f	cmevqt14a0003md3mor8yopoo	cmf639l450000k7e5xwbydd9t	2025-09-05 17:38:34.08	f	\N	\N	\N	\N
cmf74gb01000310jyje66hz1t	[AUTO] Prepared and filed court documents	1.000000000000000000000000000000	150.000000000000000000000000000000	150.000000000000000000000000000000	2025-09-05 17:41:27.601	t	f	cmevqt14a0003md3mor8yopoo	cmf639l450000k7e5xwbydd9t	2025-09-05 17:41:27.601	f	\N	\N	\N	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."User" (id, email, password, name, "firstName", "lastName", role, "isActive", phone, address, "barNumber", signature, "hourlyRate", "emailVerified", "emailVerificationToken", "passwordResetToken", "passwordResetExpires", "loginAttempts", "lockedUntil", "twoFactorSecret", "twoFactorEnabled", "createdAt", "updatedAt", "lastLogin") FROM stdin;
cmexiqs420000l5dhtoudak11	admin@example.com	$2a$10$0uVbYNBqBjSSpnek68gJzuTe.SPWDzhCJEYDJDEcbsSmP1MF5vGXm	Admin User	\N	\N	SUPER_ADMIN	t	\N	\N	\N	\N	\N	f	\N	ce3854429b7909592c6b60db07073ff7b2ad78305c22506339a6b3be8cb20a1c	2025-08-31 17:09:51.851+00	0	\N	\N	f	2025-08-30 00:23:49.203+00	2025-08-31 16:09:51.852+00	2025-08-31 16:09:37.608+00
cmezy68ks000011hv1bcrzwal	test@admin.com	$2a$10$5JyAUBbQiI.N5zz/jV8oienCAmPtIRc7derzRA0ICybStL6BWgoMS	Test Admin	\N	\N	SUPER_ADMIN	t	\N	\N	\N	\N	\N	f	\N	f90b50895fcfd1ff41dbfdfbec1bb6698cd2db46be034aa1d7e778b038888590	2025-08-31 19:10:05.763+00	0	\N	\N	f	2025-08-31 17:11:16.972+00	2025-08-31 18:10:05.764+00	2025-08-31 18:10:05.69+00
cmf639l450000k7e5xwbydd9t	admin@legalestate.com	$2a$10$UZ2B0HykxF8Sg7g8Djld5eJeL1qcTG437CrPgPnpZRMKi1m94Q3bm	Admin User	Admin	User	ADMIN	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-05 00:20:28.325+00	2025-09-05 00:20:28.325+00	\N
cmf639l7t0001k7e53xknnv6x	demo@legalestate.com	$2a$10$hSP19TscrGfFVpNaTFDpdObTU10VPk5BZwEsjs91nsTn6YVMDLTqe	Demo Attorney	Demo	Attorney	ATTORNEY	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-05 00:20:28.458+00	2025-09-05 00:20:28.458+00	\N
cmf639lbe0002k7e53hk6cxdk	paralegal@legalestate.com	$2a$10$yri.b6EuS5c/yd7/1O9kv.qB0z3t.ESemYYfnnuPfF/cLLV/V5HnK	Demo Paralegal	Demo	Paralegal	PARALEGAL	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-05 00:20:28.587+00	2025-09-05 00:20:28.587+00	\N
test-user-id	client@legalestate.tech	$2a$10$HFk5jzfESaTWZg7wj4ilHOF5jiiLxzlvhWjaTbB9AJ0VF5uhsnR6y	Demo Client	Legal	Client	CLIENT	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-08-28 18:33:58.686+00	2025-09-21 01:36:43.934+00	2025-08-30 00:14:16.543+00
cmft162am0000wlyczg6bm5kw	demo@legalestate.tech	$2a$10$lbsYAvEVvAOIIkq59W9qxeEsOVE2Vn/zf58hjdT5/dMIjgBUoT/Fy	Demo Administrator	\N	\N	SUPER_ADMIN	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-21 01:40:26.782+00	2025-09-21 01:40:26.782+00	\N
cmfeqxbng000ml55mfna3izs7	test.user@example.com	$2a$12$VioO7zYIrJq0zK890eUxJuuTako2Gwq7z9p6RivLcc9Hs/lO8GUWu	Test User	\N	\N	ATTORNEY	t	\N	\N	\N	\N	\N	f	e0782a41217b9144f2daec817be6b2deb97e362fb2cdc9b5066736257d66e8f6	6b7e846b59355cfb28cd176444cdcfbc80d2243b13a325ee50f4c77aad1b134e	2025-09-11 15:16:17.425+00	1	\N	\N	f	2025-09-11 01:44:56.38+00	2025-09-11 14:16:17.426+00	2025-09-11 14:16:16.904+00
cmft162db0001wlycsrhceqp9	user@legalestate.tech	$2a$10$Ct37LVuk.CU0pqMkT3ZXuuHcmk3xnJwZO86d5/ZNH.AjUysiTu0v2	Demo User	\N	\N	ATTORNEY	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-21 01:40:26.88+00	2025-09-21 01:40:26.88+00	\N
cmft162fs0002wlycsutw7miw	client@demo.tech	$2a$10$HvuRsHMp3Y9wMR0kdri2hOwYAQZas8uPjeWD7zCkXBLGCYTyLUP7K	Demo Client	\N	\N	CLIENT	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-21 01:40:26.968+00	2025-09-21 01:40:26.968+00	\N
ce7cadbe0f01fcdc79a0138a826d5969	admin@legalestate.tech	$2a$10$7DYiOHMBimpI0lOzoltxLe1rVwjlneHy8yJvZlARDycuKmJLqlkiu	System Administrator	Legal	Admin	SUPER_ADMIN	t	\N	\N	\N	\N	\N	t	\N	\N	\N	0	\N	\N	f	2025-08-28 18:52:32.518+00	2025-09-21 01:36:43.646+00	2025-08-30 15:59:48.357+00
cmft10z8q0001iagafwo0f7y6	attorney@legalestate.tech	$2a$10$c6qhXONe5/FF9uzAi0jZqeKdAr.Fqbp4y7sHDwaPbfJ6JQsEUypO.	John Attorney	\N	\N	ADMIN	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-21 01:36:29.546+00	2025-09-21 01:36:43.754+00	\N
cmft11a9u000213k0lnahzriw	paralegal@legalestate.tech	$2a$10$8rmGUp7.rlPiskcnfBccb.PYbG1VMTaAyI0qyS8aCImyt9oXxA9wi	Sarah Paralegal	\N	\N	PARALEGAL	t	\N	\N	\N	\N	\N	f	\N	\N	\N	0	\N	\N	f	2025-09-21 01:36:43.842+00	2025-09-21 01:36:43.842+00	\N
\.


--
-- Data for Name: _CaseToMedicalProvider; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public."_CaseToMedicalProvider" ("A", "B") FROM stdin;
\.


--
-- Data for Name: calendar_events; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.calendar_events (id, title, description, type, "startDate", "endDate", "startTime", "endTime", "allDay", location, "caseId", "clientId", "createdById", "assignedToId", attendees, "judgeId", courtroom, "caseNumber", "reminderSent", "reminderTime", completed, cancelled, rescheduled, "originalEventId", "isRecurring", "recurringRule", "parentEventId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: case_deadlines; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.case_deadlines (id, "caseId", title, description, "dueDate", type, priority, "isStatutory", "reminderDays", completed, "completedAt", "completedById") FROM stdin;
\.


--
-- Data for Name: case_status_history; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.case_status_history (id, "caseId", "fromStatus", "toStatus", "changedAt", "changedById", reason, notes) FROM stdin;
8ab1bb81c48ec54fceacb3b1e189bf14	cmevqt14a0003md3mor8yopoo	\N	INTAKE	2025-08-28 18:33:58.772+00	test-user-id	Case created	Initial case status
\.


--
-- Data for Name: case_template_tasks; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.case_template_tasks (id, "templateId", title, description, "taskType", priority, "estimatedHours", "dueDaysFromStart", "dueDaysFromStep", "assignToRole", "assignToField", "prerequisiteTasks", "templateOrder", "isRequired", "createdAt") FROM stdin;
\.


--
-- Data for Name: case_templates; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.case_templates (id, name, description, "caseType", "templateType", "isActive", "isDefault", "defaultStatus", "defaultPriority", "defaultStage", "workflowSteps", "taskTemplates", "deadlineTemplates", "documentTemplates", "communicationTemplates", "createdById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: case_values; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.case_values (id, "caseId", "valueType", amount, description, date, "enteredById", "isActive") FROM stdin;
b0bdf71c37777fd6388e08dfa797849d	cmevqt14a0003md3mor8yopoo	INITIAL_ESTIMATE	75000.00	Initial estimated case value	2025-08-28	test-user-id	t
\.


--
-- Data for Name: case_workflow_steps; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.case_workflow_steps (id, "templateId", "caseId", name, description, "stepOrder", "estimatedDays", "prerequisiteSteps", "autoCreateTasks", "autoCreateDeadlines", "autoCreateDocuments", "taskTemplate", "taskTitle", "taskDescription", "taskDueDays", "isCompleted", "completedAt", "completedById", "createdAt") FROM stdin;
\.


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.cases (id, "caseNumber", title, description, type, status, priority, stage, source, "dateOpened", "consultationDate", "retainerSignedDate", "discoveryStartDate", "discoveryEndDate", "mediationDate", "trialDate", "settlementDate", "dateClosed", statute, "nextDeadline", "deadlineDescription", "clientId", "attorneyId", "paralegalId", "secondAttorneyId", "referringAttorneyId", "estimatedValue", "demandAmount", "settlementAmount", "attorneyFees", costs, "netToClient", "contingencyRate", "hoursWorked", "totalBilled", "costsIncurred", "isActive", "isArchived", "internalNotes", "clientInstructions", "workflowTemplate", "customFields", "createdAt", "updatedAt") FROM stdin;
cmevqt14a0003md3mor8yopoo	CS20250001	Personal Injury Case - Car Accident on I-95	Client was rear-ended on I-95, sustained injuries including whiplash and back pain	AUTO_ACCIDENT	INTAKE	HIGH	PRE_LITIGATION	REFERRAL_ATTORNEY	2025-08-28	\N	\N	\N	\N	\N	\N	\N	\N	2027-08-28	\N	\N	cmevqt13e0001md3m8v7svvbo	test-user-id	\N	\N	\N	75000.00	\N	\N	\N	\N	\N	33.33	0.00	0.00	0.00	t	f	Client seems credible, good potential case	Client wants aggressive representation	\N	\N	2025-08-28 18:33:58.762+00	2025-08-28 18:33:58.762+00
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.clients (id, "firstName", "lastName", email, phone, address, city, state, "zipCode", "dateOfBirth", ssn, "emergencyContact", "emergencyPhone", notes, source, "createdAt", "updatedAt", "createdById", mobile, "workPhone", employer, occupation, "maritalStatus", "spouseName", "preferredContact", "isActive", "clientNumber") FROM stdin;
cmevqt13e0001md3m8v7svvbo	John	Doe	john.doe@example.com	15551234567	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-28 18:33:58.73+00	2025-08-28 18:33:58.73+00	test-user-id	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	CL20250001
cmezvm58d000139iauozlch2e	Test	Client	test@example.com	1234567890	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-31 15:59:40.285+00	2025-08-31 15:59:40.285+00	cmexiqs420000l5dhtoudak11	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	\N
cmezvqurg000539iab6hf2sd0	E2E	Test	e2e@test.com	9999999999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-31 16:03:19.996+00	2025-08-31 16:03:19.996+00	cmexiqs420000l5dhtoudak11	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	\N
cmezvrar5000939ia801zcaxl	Final	Test	final@test.com	5555555555	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-31 16:03:40.721+00	2025-08-31 16:03:40.721+00	cmexiqs420000l5dhtoudak11	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	\N
cmezyogiq000211hvlzpuon77	John	Smith	john@example.com	555-1234	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-31 17:25:27.055+00	2025-08-31 17:25:27.055+00	cmezy68ks000011hv1bcrzwal	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	\N
cmf797yvh00017j5nxr7aaz72	Ted	Rubin	ted@legalestate.tech	1914111111					1980-05-17	\N				\N	2025-09-05 19:54:56.717+00	2025-09-05 19:54:56.717+00	ce7cadbe0f01fcdc79a0138a826d5969	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	\N
cmfeqwzzu0007l55moytz4mph	Test	Error	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 01:44:41.275+00	2025-09-11 01:44:41.275+00	test-user-id	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	CL20250002
cmfeqx1qh0009l55myst3e0jo	John	Doe	john.doe@example.com	15551234567	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 01:44:43.529+00	2025-09-11 01:44:43.529+00	test-user-id	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	CL20250003
cmfeqx9g0000ll55mdo7ch2sx	John	Doe	john.doe@example.com	15551234567	123 Main Street	New York	NY	10001	\N	\N	\N	\N	\N	\N	2025-09-11 01:44:53.521+00	2025-09-11 01:44:53.521+00	test-user-id	15559876543	\N	Tech Corp	Software Engineer	MARRIED	Jane Doe	EMAIL	t	CL20250004
cmffhrso80009lcbtzr1l94pe	John	Doe	john.doe@example.com	15551234567	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 14:16:28.136+00	2025-09-11 14:16:28.136+00	test-user-id	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	CL20250005
cmffhrw69000hlcbt1hyvhyqx	John	Doe	john.doe@example.com	15551234567	123 Main Street	New York	NY	10001	\N	\N	\N	\N	\N	\N	2025-09-11 14:16:32.673+00	2025-09-11 14:16:32.673+00	test-user-id	15559876543	\N	Tech Corp	Software Engineer	MARRIED	Jane Doe	EMAIL	t	CL20250006
cmffhrzn7000llcbtpml0q8v9	Test	Error	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 14:16:37.171+00	2025-09-11 14:16:37.171+00	test-user-id	\N	\N	\N	\N	SINGLE	\N	EMAIL	t	CL20250007
\.


--
-- Data for Name: communication_attachments; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.communication_attachments (id, "fileName", "originalName", "mimeType", "fileSize", "filePath", "isConfidential", "communicationId", "uploadedBy", "createdAt") FROM stdin;
\.


--
-- Data for Name: communications; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.communications (id, type, direction, status, subject, content, summary, "dateTime", duration, "followUpRequired", "followUpDate", priority, "fromEmail", "toEmails", "fromPhone", "toPhone", "attachmentCount", "isConfidential", billable, "billingNotes", "caseId", "clientId", "userId", "createdAt", "updatedAt") FROM stdin;
cmfeqx1s9000bl55mi7ix2txt	EMAIL	OUTBOUND	DELIVERED	Updated Case Status	Dear Mr. Doe, I wanted to provide you with an update on your case...	Client responded positively to case update	2025-09-11 01:44:41.692	\N	t	2025-09-18 01:44:41.692	NORMAL	attorney@lawfirm.com	{john.doe@example.com}	\N	\N	0	f	t	\N	\N	cmfeqx1qh0009l55myst3e0jo	test-user-id	2025-09-11 01:44:43.594+00	2025-09-11 01:44:43.879+00
cmfeqx229000dl55m20pg6dzv	PHONE	INBOUND	SENT	\N	Client called regarding case status	\N	2025-09-11 01:44:43.941	15	f	\N	NORMAL	\N	\N	15551234567	15559876543	0	f	t	\N	\N	cmfeqx1qh0009l55myst3e0jo	test-user-id	2025-09-11 01:44:43.954+00	2025-09-11 01:44:43.954+00
cmfeqx22t000fl55m56awhuuz	MEETING	OUTBOUND	SENT	Initial client consultation	Met with client to discuss case details and strategy	\N	2025-09-11 01:44:43.967	60	f	\N	HIGH	\N	\N	\N	\N	0	t	t	\N	\N	cmfeqx1qh0009l55myst3e0jo	test-user-id	2025-09-11 01:44:43.973+00	2025-09-11 01:44:43.973+00
cmffhrsph000blcbtmtav0654	EMAIL	OUTBOUND	DELIVERED	Updated Case Status	Dear Mr. Doe, I wanted to provide you with an update on your case...	Client responded positively to case update	2025-09-11 14:16:26.356	\N	t	2025-09-18 14:16:26.357	NORMAL	attorney@lawfirm.com	{john.doe@example.com}	\N	\N	0	f	t	\N	\N	cmffhrso80009lcbtzr1l94pe	test-user-id	2025-09-11 14:16:28.181+00	2025-09-11 14:16:28.543+00
cmffhrt0y000dlcbtkpoerxw3	PHONE	INBOUND	SENT	\N	Client called regarding case status	\N	2025-09-11 14:16:28.584	15	f	\N	NORMAL	\N	\N	15551234567	15559876543	0	f	t	\N	\N	cmffhrso80009lcbtzr1l94pe	test-user-id	2025-09-11 14:16:28.594+00	2025-09-11 14:16:28.594+00
cmffhrt1d000flcbtmkce4t1w	MEETING	OUTBOUND	SENT	Initial client consultation	Met with client to discuss case details and strategy	\N	2025-09-11 14:16:28.605	60	f	\N	HIGH	\N	\N	\N	\N	0	t	t	\N	\N	cmffhrso80009lcbtzr1l94pe	test-user-id	2025-09-11 14:16:28.609+00	2025-09-11 14:16:28.609+00
\.


--
-- Data for Name: emergency_contacts; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.emergency_contacts (id, "firstName", "lastName", relationship, phone, email, address, "isPrimary", "clientId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: incidents; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.incidents (id, "caseId", "dateOfIncident", "timeOfIncident", location, description, "policeReport", "policeReportNum", "weatherConditions", witnesses, photos, "createdAt") FROM stdin;
\.


--
-- Data for Name: invoice_line_items; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.invoice_line_items (id, "invoiceId", description, quantity, rate, amount, "timeEntryId", "expenseId", "createdAt") FROM stdin;
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.invoices (id, "invoiceNumber", "clientId", "caseId", "issueDate", "dueDate", "paidDate", status, subtotal, "taxRate", "taxAmount", "totalAmount", "paidAmount", "balanceDue", "paymentMethod", "paymentReference", description, notes, terms, "createdById", "sentToClient", "sentDate", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.notifications (id, type, title, message, "userId", "entityType", "entityId", "isRead", "readAt", "scheduledFor", status, metadata, "createdAt") FROM stdin;
\.


--
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: legal_user
--

COPY public.settlements (id, "caseId", amount, status, "proposedDate", "acceptedDate", "executedDate", "paidDate", "attorneyFees", costs, "netToClient", "attorneyPercent", "paymentTerms", "paymentSchedule", settlor, "payorContact", "payorPhone", "payorEmail", description, conditions, confidential, releases, "demandLetterSent", "agreementSigned", "releasesSigned", "negotiatedById", "approvedById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Name: Activity Activity_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_pkey" PRIMARY KEY (id);


--
-- Name: AiProviderConfig AiProviderConfig_pkey; Type: CONSTRAINT; Schema: public; Owner: legalestate_admin
--

ALTER TABLE ONLY public."AiProviderConfig"
    ADD CONSTRAINT "AiProviderConfig_pkey" PRIMARY KEY (id);


--
-- Name: CaseActivity CaseActivity_pkey; Type: CONSTRAINT; Schema: public; Owner: legalestate_admin
--

ALTER TABLE ONLY public."CaseActivity"
    ADD CONSTRAINT "CaseActivity_pkey" PRIMARY KEY (id);


--
-- Name: Document Document_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_pkey" PRIMARY KEY (id);


--
-- Name: Expense Expense_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Expense"
    ADD CONSTRAINT "Expense_pkey" PRIMARY KEY (id);


--
-- Name: Insurance Insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Insurance"
    ADD CONSTRAINT "Insurance_pkey" PRIMARY KEY (id);


--
-- Name: MedicalProvider MedicalProvider_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."MedicalProvider"
    ADD CONSTRAINT "MedicalProvider_pkey" PRIMARY KEY (id);


--
-- Name: MedicalRecord MedicalRecord_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."MedicalRecord"
    ADD CONSTRAINT "MedicalRecord_pkey" PRIMARY KEY (id);


--
-- Name: Note Note_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_pkey" PRIMARY KEY (id);


--
-- Name: Task Task_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (id);


--
-- Name: TimeEntry TimeEntry_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."TimeEntry"
    ADD CONSTRAINT "TimeEntry_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: calendar_events calendar_events_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT calendar_events_pkey PRIMARY KEY (id);


--
-- Name: case_deadlines case_deadlines_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_deadlines
    ADD CONSTRAINT case_deadlines_pkey PRIMARY KEY (id);


--
-- Name: case_status_history case_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_status_history
    ADD CONSTRAINT case_status_history_pkey PRIMARY KEY (id);


--
-- Name: case_template_tasks case_template_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_template_tasks
    ADD CONSTRAINT case_template_tasks_pkey PRIMARY KEY (id);


--
-- Name: case_templates case_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_templates
    ADD CONSTRAINT case_templates_pkey PRIMARY KEY (id);


--
-- Name: case_values case_values_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_values
    ADD CONSTRAINT case_values_pkey PRIMARY KEY (id);


--
-- Name: case_workflow_steps case_workflow_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_workflow_steps
    ADD CONSTRAINT case_workflow_steps_pkey PRIMARY KEY (id);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: communication_attachments communication_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communication_attachments
    ADD CONSTRAINT communication_attachments_pkey PRIMARY KEY (id);


--
-- Name: communications communications_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communications
    ADD CONSTRAINT communications_pkey PRIMARY KEY (id);


--
-- Name: emergency_contacts emergency_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_pkey PRIMARY KEY (id);


--
-- Name: incidents incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: invoice_line_items invoice_line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoice_line_items
    ADD CONSTRAINT invoice_line_items_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: settlements settlements_pkey; Type: CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT settlements_pkey PRIMARY KEY (id);


--
-- Name: Activity_createdAt_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Activity_createdAt_idx" ON public."Activity" USING btree ("createdAt");


--
-- Name: Activity_entityType_entityId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Activity_entityType_entityId_idx" ON public."Activity" USING btree ("entityType", "entityId");


--
-- Name: Activity_userId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Activity_userId_idx" ON public."Activity" USING btree ("userId");


--
-- Name: AiProviderConfig_provider_key; Type: INDEX; Schema: public; Owner: legalestate_admin
--

CREATE UNIQUE INDEX "AiProviderConfig_provider_key" ON public."AiProviderConfig" USING btree (provider);


--
-- Name: CaseActivity_activityType_idx; Type: INDEX; Schema: public; Owner: legalestate_admin
--

CREATE INDEX "CaseActivity_activityType_idx" ON public."CaseActivity" USING btree ("activityType");


--
-- Name: CaseActivity_caseId_idx; Type: INDEX; Schema: public; Owner: legalestate_admin
--

CREATE INDEX "CaseActivity_caseId_idx" ON public."CaseActivity" USING btree ("caseId");


--
-- Name: CaseActivity_isBillable_idx; Type: INDEX; Schema: public; Owner: legalestate_admin
--

CREATE INDEX "CaseActivity_isBillable_idx" ON public."CaseActivity" USING btree ("isBillable");


--
-- Name: CaseActivity_startTime_idx; Type: INDEX; Schema: public; Owner: legalestate_admin
--

CREATE INDEX "CaseActivity_startTime_idx" ON public."CaseActivity" USING btree ("startTime");


--
-- Name: CaseActivity_userId_idx; Type: INDEX; Schema: public; Owner: legalestate_admin
--

CREATE INDEX "CaseActivity_userId_idx" ON public."CaseActivity" USING btree ("userId");


--
-- Name: Document_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Document_caseId_idx" ON public."Document" USING btree ("caseId");


--
-- Name: Document_createdAt_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Document_createdAt_idx" ON public."Document" USING btree ("createdAt");


--
-- Name: Document_lastViewed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Document_lastViewed_idx" ON public."Document" USING btree ("lastViewed");


--
-- Name: Document_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Document_type_idx" ON public."Document" USING btree (type);


--
-- Name: Document_viewCount_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Document_viewCount_idx" ON public."Document" USING btree ("viewCount");


--
-- Name: Expense_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Expense_caseId_idx" ON public."Expense" USING btree ("caseId");


--
-- Name: Expense_date_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Expense_date_idx" ON public."Expense" USING btree (date);


--
-- Name: Expense_reimbursed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Expense_reimbursed_idx" ON public."Expense" USING btree (reimbursed);


--
-- Name: Insurance_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Insurance_caseId_idx" ON public."Insurance" USING btree ("caseId");


--
-- Name: MedicalProvider_name_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "MedicalProvider_name_idx" ON public."MedicalProvider" USING btree (name);


--
-- Name: MedicalRecord_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "MedicalRecord_caseId_idx" ON public."MedicalRecord" USING btree ("caseId");


--
-- Name: MedicalRecord_providerId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "MedicalRecord_providerId_idx" ON public."MedicalRecord" USING btree ("providerId");


--
-- Name: Note_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Note_caseId_idx" ON public."Note" USING btree ("caseId");


--
-- Name: Task_assignedToId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Task_assignedToId_idx" ON public."Task" USING btree ("assignedToId");


--
-- Name: Task_dueDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Task_dueDate_idx" ON public."Task" USING btree ("dueDate");


--
-- Name: Task_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "Task_status_idx" ON public."Task" USING btree (status);


--
-- Name: TimeEntry_billable_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "TimeEntry_billable_idx" ON public."TimeEntry" USING btree (billable);


--
-- Name: TimeEntry_billed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "TimeEntry_billed_idx" ON public."TimeEntry" USING btree (billed);


--
-- Name: TimeEntry_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "TimeEntry_caseId_idx" ON public."TimeEntry" USING btree ("caseId");


--
-- Name: TimeEntry_date_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "TimeEntry_date_idx" ON public."TimeEntry" USING btree (date);


--
-- Name: TimeEntry_userId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "TimeEntry_userId_idx" ON public."TimeEntry" USING btree ("userId");


--
-- Name: User_barNumber_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_barNumber_idx" ON public."User" USING btree ("barNumber");


--
-- Name: User_barNumber_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "User_barNumber_key" ON public."User" USING btree ("barNumber");


--
-- Name: User_createdAt_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_createdAt_idx" ON public."User" USING btree ("createdAt");


--
-- Name: User_emailVerificationToken_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "User_emailVerificationToken_key" ON public."User" USING btree ("emailVerificationToken");


--
-- Name: User_emailVerified_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_emailVerified_idx" ON public."User" USING btree ("emailVerified");


--
-- Name: User_email_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_email_idx" ON public."User" USING btree (email);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_isActive_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_isActive_idx" ON public."User" USING btree ("isActive");


--
-- Name: User_lastLogin_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_lastLogin_idx" ON public."User" USING btree ("lastLogin");


--
-- Name: User_lockedUntil_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_lockedUntil_idx" ON public."User" USING btree ("lockedUntil");


--
-- Name: User_passwordResetExpires_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_passwordResetExpires_idx" ON public."User" USING btree ("passwordResetExpires");


--
-- Name: User_passwordResetToken_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_passwordResetToken_idx" ON public."User" USING btree ("passwordResetToken");


--
-- Name: User_passwordResetToken_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "User_passwordResetToken_key" ON public."User" USING btree ("passwordResetToken");


--
-- Name: User_role_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "User_role_idx" ON public."User" USING btree (role);


--
-- Name: _CaseToMedicalProvider_AB_unique; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "_CaseToMedicalProvider_AB_unique" ON public."_CaseToMedicalProvider" USING btree ("A", "B");


--
-- Name: _CaseToMedicalProvider_B_index; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "_CaseToMedicalProvider_B_index" ON public."_CaseToMedicalProvider" USING btree ("B");


--
-- Name: calendar_events_assignedToId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "calendar_events_assignedToId_idx" ON public.calendar_events USING btree ("assignedToId");


--
-- Name: calendar_events_cancelled_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX calendar_events_cancelled_idx ON public.calendar_events USING btree (cancelled);


--
-- Name: calendar_events_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "calendar_events_caseId_idx" ON public.calendar_events USING btree ("caseId");


--
-- Name: calendar_events_completed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX calendar_events_completed_idx ON public.calendar_events USING btree (completed);


--
-- Name: calendar_events_createdById_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "calendar_events_createdById_idx" ON public.calendar_events USING btree ("createdById");


--
-- Name: calendar_events_startDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "calendar_events_startDate_idx" ON public.calendar_events USING btree ("startDate");


--
-- Name: calendar_events_startDate_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "calendar_events_startDate_type_idx" ON public.calendar_events USING btree ("startDate", type);


--
-- Name: calendar_events_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX calendar_events_type_idx ON public.calendar_events USING btree (type);


--
-- Name: case_deadlines_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_deadlines_caseId_idx" ON public.case_deadlines USING btree ("caseId");


--
-- Name: case_deadlines_completed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX case_deadlines_completed_idx ON public.case_deadlines USING btree (completed);


--
-- Name: case_deadlines_dueDate_completed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_deadlines_dueDate_completed_idx" ON public.case_deadlines USING btree ("dueDate", completed);


--
-- Name: case_deadlines_dueDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_deadlines_dueDate_idx" ON public.case_deadlines USING btree ("dueDate");


--
-- Name: case_deadlines_isStatutory_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_deadlines_isStatutory_idx" ON public.case_deadlines USING btree ("isStatutory");


--
-- Name: case_deadlines_priority_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX case_deadlines_priority_idx ON public.case_deadlines USING btree (priority);


--
-- Name: case_deadlines_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX case_deadlines_type_idx ON public.case_deadlines USING btree (type);


--
-- Name: case_status_history_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_status_history_caseId_idx" ON public.case_status_history USING btree ("caseId");


--
-- Name: case_status_history_changedAt_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_status_history_changedAt_idx" ON public.case_status_history USING btree ("changedAt");


--
-- Name: case_status_history_changedById_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_status_history_changedById_idx" ON public.case_status_history USING btree ("changedById");


--
-- Name: case_status_history_toStatus_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_status_history_toStatus_idx" ON public.case_status_history USING btree ("toStatus");


--
-- Name: case_template_tasks_taskType_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_template_tasks_taskType_idx" ON public.case_template_tasks USING btree ("taskType");


--
-- Name: case_template_tasks_templateId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_template_tasks_templateId_idx" ON public.case_template_tasks USING btree ("templateId");


--
-- Name: case_template_tasks_templateOrder_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_template_tasks_templateOrder_idx" ON public.case_template_tasks USING btree ("templateOrder");


--
-- Name: case_templates_caseType_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_templates_caseType_idx" ON public.case_templates USING btree ("caseType");


--
-- Name: case_templates_caseType_isDefault_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_templates_caseType_isDefault_idx" ON public.case_templates USING btree ("caseType", "isDefault");


--
-- Name: case_templates_isActive_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_templates_isActive_idx" ON public.case_templates USING btree ("isActive");


--
-- Name: case_templates_isDefault_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_templates_isDefault_idx" ON public.case_templates USING btree ("isDefault");


--
-- Name: case_templates_templateType_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_templates_templateType_idx" ON public.case_templates USING btree ("templateType");


--
-- Name: case_values_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_values_caseId_idx" ON public.case_values USING btree ("caseId");


--
-- Name: case_values_caseId_valueType_isActive_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_values_caseId_valueType_isActive_idx" ON public.case_values USING btree ("caseId", "valueType", "isActive");


--
-- Name: case_values_date_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX case_values_date_idx ON public.case_values USING btree (date);


--
-- Name: case_values_isActive_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_values_isActive_idx" ON public.case_values USING btree ("isActive");


--
-- Name: case_values_valueType_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_values_valueType_idx" ON public.case_values USING btree ("valueType");


--
-- Name: case_workflow_steps_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_workflow_steps_caseId_idx" ON public.case_workflow_steps USING btree ("caseId");


--
-- Name: case_workflow_steps_caseId_stepOrder_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_workflow_steps_caseId_stepOrder_idx" ON public.case_workflow_steps USING btree ("caseId", "stepOrder");


--
-- Name: case_workflow_steps_isCompleted_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_workflow_steps_isCompleted_idx" ON public.case_workflow_steps USING btree ("isCompleted");


--
-- Name: case_workflow_steps_stepOrder_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_workflow_steps_stepOrder_idx" ON public.case_workflow_steps USING btree ("stepOrder");


--
-- Name: case_workflow_steps_templateId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "case_workflow_steps_templateId_idx" ON public.case_workflow_steps USING btree ("templateId");


--
-- Name: cases_attorneyId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_attorneyId_idx" ON public.cases USING btree ("attorneyId");


--
-- Name: cases_caseNumber_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_caseNumber_idx" ON public.cases USING btree ("caseNumber");


--
-- Name: cases_caseNumber_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "cases_caseNumber_key" ON public.cases USING btree ("caseNumber");


--
-- Name: cases_clientId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_clientId_idx" ON public.cases USING btree ("clientId");


--
-- Name: cases_createdAt_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_createdAt_idx" ON public.cases USING btree ("createdAt");


--
-- Name: cases_dateClosed_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_dateClosed_idx" ON public.cases USING btree ("dateClosed");


--
-- Name: cases_dateOpened_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_dateOpened_idx" ON public.cases USING btree ("dateOpened");


--
-- Name: cases_isActive_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_isActive_idx" ON public.cases USING btree ("isActive");


--
-- Name: cases_isArchived_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_isArchived_idx" ON public.cases USING btree ("isArchived");


--
-- Name: cases_nextDeadline_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_nextDeadline_idx" ON public.cases USING btree ("nextDeadline");


--
-- Name: cases_nextDeadline_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_nextDeadline_status_idx" ON public.cases USING btree ("nextDeadline", status);


--
-- Name: cases_paralegalId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_paralegalId_idx" ON public.cases USING btree ("paralegalId");


--
-- Name: cases_priority_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_priority_idx ON public.cases USING btree (priority);


--
-- Name: cases_referringAttorneyId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_referringAttorneyId_idx" ON public.cases USING btree ("referringAttorneyId");


--
-- Name: cases_secondAttorneyId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "cases_secondAttorneyId_idx" ON public.cases USING btree ("secondAttorneyId");


--
-- Name: cases_source_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_source_idx ON public.cases USING btree (source);


--
-- Name: cases_stage_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_stage_idx ON public.cases USING btree (stage);


--
-- Name: cases_stage_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_stage_status_idx ON public.cases USING btree (stage, status);


--
-- Name: cases_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_status_idx ON public.cases USING btree (status);


--
-- Name: cases_status_priority_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_status_priority_idx ON public.cases USING btree (status, priority);


--
-- Name: cases_status_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_status_type_idx ON public.cases USING btree (status, type);


--
-- Name: cases_statute_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_statute_idx ON public.cases USING btree (statute);


--
-- Name: cases_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX cases_type_idx ON public.cases USING btree (type);


--
-- Name: clients_clientNumber_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "clients_clientNumber_key" ON public.clients USING btree ("clientNumber");


--
-- Name: clients_createdAt_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "clients_createdAt_idx" ON public.clients USING btree ("createdAt");


--
-- Name: clients_createdById_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "clients_createdById_idx" ON public.clients USING btree ("createdById");


--
-- Name: clients_email_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX clients_email_idx ON public.clients USING btree (email);


--
-- Name: clients_lastName_firstName_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "clients_lastName_firstName_idx" ON public.clients USING btree ("lastName", "firstName");


--
-- Name: clients_source_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX clients_source_idx ON public.clients USING btree (source);


--
-- Name: clients_state_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX clients_state_idx ON public.clients USING btree (state);


--
-- Name: clients_zipCode_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "clients_zipCode_idx" ON public.clients USING btree ("zipCode");


--
-- Name: communication_attachments_communicationId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "communication_attachments_communicationId_idx" ON public.communication_attachments USING btree ("communicationId");


--
-- Name: communications_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "communications_caseId_idx" ON public.communications USING btree ("caseId");


--
-- Name: communications_clientId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "communications_clientId_idx" ON public.communications USING btree ("clientId");


--
-- Name: communications_dateTime_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "communications_dateTime_idx" ON public.communications USING btree ("dateTime");


--
-- Name: communications_followUpRequired_followUpDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "communications_followUpRequired_followUpDate_idx" ON public.communications USING btree ("followUpRequired", "followUpDate");


--
-- Name: communications_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX communications_status_idx ON public.communications USING btree (status);


--
-- Name: communications_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX communications_type_idx ON public.communications USING btree (type);


--
-- Name: communications_userId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "communications_userId_idx" ON public.communications USING btree ("userId");


--
-- Name: emergency_contacts_clientId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "emergency_contacts_clientId_idx" ON public.emergency_contacts USING btree ("clientId");


--
-- Name: incidents_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "incidents_caseId_idx" ON public.incidents USING btree ("caseId");


--
-- Name: incidents_dateOfIncident_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "incidents_dateOfIncident_idx" ON public.incidents USING btree ("dateOfIncident");


--
-- Name: invoice_line_items_expenseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoice_line_items_expenseId_idx" ON public.invoice_line_items USING btree ("expenseId");


--
-- Name: invoice_line_items_invoiceId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoice_line_items_invoiceId_idx" ON public.invoice_line_items USING btree ("invoiceId");


--
-- Name: invoice_line_items_timeEntryId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoice_line_items_timeEntryId_idx" ON public.invoice_line_items USING btree ("timeEntryId");


--
-- Name: invoices_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_caseId_idx" ON public.invoices USING btree ("caseId");


--
-- Name: invoices_clientId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_clientId_idx" ON public.invoices USING btree ("clientId");


--
-- Name: invoices_createdById_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_createdById_idx" ON public.invoices USING btree ("createdById");


--
-- Name: invoices_dueDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_dueDate_idx" ON public.invoices USING btree ("dueDate");


--
-- Name: invoices_invoiceNumber_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_invoiceNumber_idx" ON public.invoices USING btree ("invoiceNumber");


--
-- Name: invoices_invoiceNumber_key; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE UNIQUE INDEX "invoices_invoiceNumber_key" ON public.invoices USING btree ("invoiceNumber");


--
-- Name: invoices_issueDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_issueDate_idx" ON public.invoices USING btree ("issueDate");


--
-- Name: invoices_paidDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_paidDate_idx" ON public.invoices USING btree ("paidDate");


--
-- Name: invoices_status_dueDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "invoices_status_dueDate_idx" ON public.invoices USING btree (status, "dueDate");


--
-- Name: invoices_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX invoices_status_idx ON public.invoices USING btree (status);


--
-- Name: notifications_entityType_entityId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "notifications_entityType_entityId_idx" ON public.notifications USING btree ("entityType", "entityId");


--
-- Name: notifications_isRead_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "notifications_isRead_idx" ON public.notifications USING btree ("isRead");


--
-- Name: notifications_scheduledFor_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "notifications_scheduledFor_idx" ON public.notifications USING btree ("scheduledFor");


--
-- Name: notifications_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX notifications_status_idx ON public.notifications USING btree (status);


--
-- Name: notifications_type_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX notifications_type_idx ON public.notifications USING btree (type);


--
-- Name: notifications_userId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "notifications_userId_idx" ON public.notifications USING btree ("userId");


--
-- Name: settlements_amount_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX settlements_amount_idx ON public.settlements USING btree (amount);


--
-- Name: settlements_caseId_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "settlements_caseId_idx" ON public.settlements USING btree ("caseId");


--
-- Name: settlements_negotiatedById_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "settlements_negotiatedById_idx" ON public.settlements USING btree ("negotiatedById");


--
-- Name: settlements_paidDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "settlements_paidDate_idx" ON public.settlements USING btree ("paidDate");


--
-- Name: settlements_proposedDate_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX "settlements_proposedDate_idx" ON public.settlements USING btree ("proposedDate");


--
-- Name: settlements_status_idx; Type: INDEX; Schema: public; Owner: legal_user
--

CREATE INDEX settlements_status_idx ON public.settlements USING btree (status);


--
-- Name: Activity Activity_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Document Document_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Document Document_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Document Document_uploadedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_uploadedBy_fkey" FOREIGN KEY ("uploadedBy") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Expense Expense_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Expense"
    ADD CONSTRAINT "Expense_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Insurance Insurance_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Insurance"
    ADD CONSTRAINT "Insurance_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicalRecord MedicalRecord_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."MedicalRecord"
    ADD CONSTRAINT "MedicalRecord_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicalRecord MedicalRecord_providerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."MedicalRecord"
    ADD CONSTRAINT "MedicalRecord_providerId_fkey" FOREIGN KEY ("providerId") REFERENCES public."MedicalProvider"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Note Note_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Note Note_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Task Task_assignedToId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Task Task_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Task Task_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TimeEntry TimeEntry_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."TimeEntry"
    ADD CONSTRAINT "TimeEntry_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TimeEntry TimeEntry_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."TimeEntry"
    ADD CONSTRAINT "TimeEntry_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: _CaseToMedicalProvider _CaseToMedicalProvider_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."_CaseToMedicalProvider"
    ADD CONSTRAINT "_CaseToMedicalProvider_A_fkey" FOREIGN KEY ("A") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CaseToMedicalProvider _CaseToMedicalProvider_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public."_CaseToMedicalProvider"
    ADD CONSTRAINT "_CaseToMedicalProvider_B_fkey" FOREIGN KEY ("B") REFERENCES public."MedicalProvider"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: calendar_events calendar_events_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT "calendar_events_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: calendar_events calendar_events_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT "calendar_events_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: calendar_events calendar_events_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT "calendar_events_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: case_deadlines case_deadlines_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_deadlines
    ADD CONSTRAINT "case_deadlines_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: case_deadlines case_deadlines_completedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_deadlines
    ADD CONSTRAINT "case_deadlines_completedById_fkey" FOREIGN KEY ("completedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: case_status_history case_status_history_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_status_history
    ADD CONSTRAINT "case_status_history_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: case_status_history case_status_history_changedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_status_history
    ADD CONSTRAINT "case_status_history_changedById_fkey" FOREIGN KEY ("changedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: case_template_tasks case_template_tasks_templateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_template_tasks
    ADD CONSTRAINT "case_template_tasks_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES public.case_templates(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: case_templates case_templates_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_templates
    ADD CONSTRAINT "case_templates_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: case_values case_values_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_values
    ADD CONSTRAINT "case_values_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: case_values case_values_enteredById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_values
    ADD CONSTRAINT "case_values_enteredById_fkey" FOREIGN KEY ("enteredById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: case_workflow_steps case_workflow_steps_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_workflow_steps
    ADD CONSTRAINT "case_workflow_steps_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: case_workflow_steps case_workflow_steps_completedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_workflow_steps
    ADD CONSTRAINT "case_workflow_steps_completedById_fkey" FOREIGN KEY ("completedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: case_workflow_steps case_workflow_steps_templateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.case_workflow_steps
    ADD CONSTRAINT "case_workflow_steps_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES public.case_templates(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cases cases_attorneyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT "cases_attorneyId_fkey" FOREIGN KEY ("attorneyId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cases cases_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT "cases_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cases cases_paralegalId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT "cases_paralegalId_fkey" FOREIGN KEY ("paralegalId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cases cases_referringAttorneyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT "cases_referringAttorneyId_fkey" FOREIGN KEY ("referringAttorneyId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cases cases_secondAttorneyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT "cases_secondAttorneyId_fkey" FOREIGN KEY ("secondAttorneyId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cases cases_workflowTemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT "cases_workflowTemplate_fkey" FOREIGN KEY ("workflowTemplate") REFERENCES public.case_templates(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: clients clients_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT "clients_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: communication_attachments communication_attachments_communicationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communication_attachments
    ADD CONSTRAINT "communication_attachments_communicationId_fkey" FOREIGN KEY ("communicationId") REFERENCES public.communications(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: communication_attachments communication_attachments_uploadedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communication_attachments
    ADD CONSTRAINT "communication_attachments_uploadedBy_fkey" FOREIGN KEY ("uploadedBy") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: communications communications_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communications
    ADD CONSTRAINT "communications_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: communications communications_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communications
    ADD CONSTRAINT "communications_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: communications communications_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.communications
    ADD CONSTRAINT "communications_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emergency_contacts emergency_contacts_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT "emergency_contacts_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: incidents incidents_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT "incidents_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invoice_line_items invoice_line_items_expenseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoice_line_items
    ADD CONSTRAINT "invoice_line_items_expenseId_fkey" FOREIGN KEY ("expenseId") REFERENCES public."Expense"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: invoice_line_items invoice_line_items_invoiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoice_line_items
    ADD CONSTRAINT "invoice_line_items_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES public.invoices(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invoice_line_items invoice_line_items_timeEntryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoice_line_items
    ADD CONSTRAINT "invoice_line_items_timeEntryId_fkey" FOREIGN KEY ("timeEntryId") REFERENCES public."TimeEntry"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: invoices invoices_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT "invoices_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: invoices invoices_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT "invoices_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: invoices invoices_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT "invoices_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notifications notifications_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: settlements settlements_caseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT "settlements_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES public.cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: settlements settlements_negotiatedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: legal_user
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT "settlements_negotiatedById_fkey" FOREIGN KEY ("negotiatedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: legalestate_admin
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: TABLE "Activity"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."Activity" TO legalestate_admin;


--
-- Name: TABLE "Document"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."Document" TO legalestate_admin;


--
-- Name: TABLE "Expense"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."Expense" TO legalestate_admin;


--
-- Name: TABLE "Insurance"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."Insurance" TO legalestate_admin;


--
-- Name: TABLE "MedicalProvider"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."MedicalProvider" TO legalestate_admin;


--
-- Name: TABLE "MedicalRecord"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."MedicalRecord" TO legalestate_admin;


--
-- Name: TABLE "Note"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."Note" TO legalestate_admin;


--
-- Name: TABLE "Task"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."Task" TO legalestate_admin;


--
-- Name: TABLE "TimeEntry"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."TimeEntry" TO legalestate_admin;


--
-- Name: TABLE "User"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."User" TO legalestate_admin;


--
-- Name: TABLE "_CaseToMedicalProvider"; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public."_CaseToMedicalProvider" TO legalestate_admin;


--
-- Name: TABLE calendar_events; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.calendar_events TO legalestate_admin;


--
-- Name: TABLE case_deadlines; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.case_deadlines TO legalestate_admin;


--
-- Name: TABLE case_status_history; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.case_status_history TO legalestate_admin;


--
-- Name: TABLE case_template_tasks; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.case_template_tasks TO legalestate_admin;


--
-- Name: TABLE case_templates; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.case_templates TO legalestate_admin;


--
-- Name: TABLE case_values; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.case_values TO legalestate_admin;


--
-- Name: TABLE case_workflow_steps; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.case_workflow_steps TO legalestate_admin;


--
-- Name: TABLE cases; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.cases TO legalestate_admin;


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.clients TO legalestate_admin;


--
-- Name: TABLE communication_attachments; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.communication_attachments TO legalestate_admin;


--
-- Name: TABLE communications; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.communications TO legalestate_admin;


--
-- Name: TABLE emergency_contacts; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.emergency_contacts TO legalestate_admin;


--
-- Name: TABLE incidents; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.incidents TO legalestate_admin;


--
-- Name: TABLE invoice_line_items; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.invoice_line_items TO legalestate_admin;


--
-- Name: TABLE invoices; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.invoices TO legalestate_admin;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.notifications TO legalestate_admin;


--
-- Name: TABLE settlements; Type: ACL; Schema: public; Owner: legal_user
--

GRANT ALL ON TABLE public.settlements TO legalestate_admin;


--
-- PostgreSQL database dump complete
--

\unrestrict 3zRpxIJdkMh00AoEaE9kwgZXkVjazn1WeYvUk6PiHl2GRmE4QDH8ayROPKj3Mn7

