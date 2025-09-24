// Demo AI Service - Provides realistic AI responses for demo purposes
export class DemoAIService {
  constructor() {
    this.isDemo = process.env.REACT_APP_DEMO_MODE === 'true';
    this.responseDelay = 1500; // Simulate AI processing time
  }

  // Simulate AI document generation
  async generateDocument(type, context = {}) {
    if (!this.isDemo) {
      throw new Error('Demo AI Service should only be used in demo mode');
    }

    await this.simulateDelay();

    const templates = {
      'demand-letter': this.generateDemandLetter(context),
      'settlement-agreement': this.generateSettlementAgreement(context),
      'motion-to-dismiss': this.generateMotionToDismiss(context),
      'discovery-request': this.generateDiscoveryRequest(context),
      'complaint': this.generateComplaint(context),
      'contract-review': this.generateContractReview(context),
    };

    return {
      success: true,
      document: templates[type] || templates['demand-letter'],
      metadata: {
        generatedAt: new Date().toISOString(),
        type: type,
        wordCount: Math.floor(Math.random() * 1000) + 500,
        confidence: 0.95,
        isDemo: true
      }
    };
  }

  // Simulate legal research
  async researchCase(query, jurisdiction = 'federal') {
    await this.simulateDelay();

    return {
      success: true,
      results: [
        {
          case: "Brown v. Board of Education",
          citation: "347 U.S. 483 (1954)",
          relevance: 0.92,
          summary: "Landmark Supreme Court case declaring state laws establishing separate public schools for black and white students to be unconstitutional.",
          keyPoints: ["Equal protection", "Segregation", "Education rights"],
          jurisdiction: "Federal"
        },
        {
          case: "Miranda v. Arizona",
          citation: "384 U.S. 436 (1966)",
          relevance: 0.87,
          summary: "Supreme Court case establishing the requirement for police to inform suspects of their rights.",
          keyPoints: ["Miranda rights", "Due process", "Self-incrimination"],
          jurisdiction: "Federal"
        },
        {
          case: "Roe v. Wade",
          citation: "410 U.S. 113 (1973)",
          relevance: 0.79,
          summary: "Supreme Court case establishing constitutional right to abortion.",
          keyPoints: ["Privacy rights", "Due process", "Constitutional interpretation"],
          jurisdiction: "Federal"
        }
      ],
      query: query,
      jurisdiction: jurisdiction,
      isDemo: true
    };
  }

  // Simulate contract analysis
  async analyzeContract(contractText) {
    await this.simulateDelay();

    return {
      success: true,
      analysis: {
        riskLevel: 'Medium',
        score: 78,
        issues: [
          {
            type: 'Termination Clause',
            severity: 'Medium',
            description: 'Termination clause heavily favors one party',
            recommendation: 'Consider adding mutual termination rights'
          },
          {
            type: 'Liability Limitation',
            severity: 'Low',
            description: 'Standard liability limitations present',
            recommendation: 'Review caps to ensure adequacy'
          }
        ],
        strengths: [
          'Clear payment terms',
          'Well-defined deliverables',
          'Appropriate governing law clause'
        ],
        suggestions: [
          'Add force majeure clause',
          'Include dispute resolution mechanism',
          'Clarify intellectual property rights'
        ]
      },
      isDemo: true
    };
  }

  // Generate realistic legal documents
  generateDemandLetter(context) {
    const { clientName = 'John Doe', defendantName = 'ABC Corporation', amount = '$25,000' } = context;

    return `DEMAND LETTER

TO: ${defendantName}
FROM: [Law Firm Name]
RE: Demand for Payment - ${clientName}

Dear Sir/Madam,

We represent ${clientName} in connection with [brief description of matter].

Our client demands payment in the amount of ${amount} for [damages/services/etc.] that remain outstanding.

This demand is made with full reservation of all rights and remedies available at law and equity.

Please remit payment within thirty (30) days of receipt of this letter to avoid further legal action.

Very truly yours,

[Attorney Name]
[Law Firm]

---
*This document was generated using AI assistance and should be reviewed by a qualified attorney.*`;
  }

  generateSettlementAgreement(context) {
    const { party1 = 'John Doe', party2 = 'Jane Smith', amount = '$15,000' } = context;

    return `SETTLEMENT AGREEMENT

This Settlement Agreement ("Agreement") is entered into between ${party1} ("Party A") and ${party2} ("Party B").

RECITALS

WHEREAS, the parties have a dispute regarding [description of dispute];

WHEREAS, the parties desire to settle all claims amicably;

NOW, THEREFORE, the parties agree as follows:

1. SETTLEMENT PAYMENT: Party B shall pay Party A the sum of ${amount}.

2. RELEASE: Upon payment, both parties release all claims against each other.

3. CONFIDENTIALITY: This agreement shall remain confidential.

4. GOVERNING LAW: This agreement shall be governed by [State] law.

IN WITNESS WHEREOF, the parties execute this Agreement.

_________________        _________________
${party1}                ${party2}

---
*This document was generated using AI assistance and should be reviewed by a qualified attorney.*`;
  }

  generateMotionToDismiss(context) {
    return `MOTION TO DISMISS

TO THE HONORABLE COURT:

Defendant respectfully moves this Court to dismiss the Complaint pursuant to Rule 12(b)(6) for failure to state a claim upon which relief can be granted.

GROUNDS FOR MOTION

1. The Complaint fails to state facts sufficient to constitute a cause of action.

2. The alleged claims are barred by the applicable statute of limitations.

3. Plaintiff lacks standing to bring this action.

WHEREFORE, Defendant respectfully requests this Court grant this Motion to Dismiss.

Respectfully submitted,

[Attorney Name]
Attorney for Defendant

---
*This document was generated using AI assistance and should be reviewed by a qualified attorney.*`;
  }

  generateDiscoveryRequest(context) {
    return `DISCOVERY REQUESTS

TO: [Opposing Party]

PLEASE TAKE NOTICE that you are hereby requested to respond to the following:

INTERROGATORIES

1. State the full name, address, and telephone number of each person with knowledge of the facts alleged in the Complaint.

2. Describe in detail each act or omission that forms the basis of your defense.

3. Identify all documents that support your position in this litigation.

REQUEST FOR PRODUCTION

1. All documents relating to the transaction described in the Complaint.

2. All communications between you and [relevant party].

3. All records of payments or financial transactions related to this matter.

Please respond within thirty (30) days.

[Attorney Name]
Attorney for Plaintiff

---
*This document was generated using AI assistance and should be reviewed by a qualified attorney.*`;
  }

  generateComplaint(context) {
    const { plaintiff = 'John Doe', defendant = 'ABC Corporation' } = context;

    return `COMPLAINT

${plaintiff}, Plaintiff, v. ${defendant}, Defendant.

COMES NOW the Plaintiff and files this Complaint against Defendant, alleging as follows:

PARTIES

1. Plaintiff is a resident of [State].
2. Defendant is a corporation organized under the laws of [State].

JURISDICTION AND VENUE

3. This Court has jurisdiction over this matter.
4. Venue is proper in this judicial district.

FACTUAL ALLEGATIONS

5. On or about [date], the parties entered into an agreement.
6. Defendant breached said agreement by [description of breach].
7. As a result, Plaintiff has suffered damages in excess of $[amount].

COUNT I - BREACH OF CONTRACT

8. Plaintiff incorporates the preceding paragraphs.
9. Defendant materially breached the contract.
10. Plaintiff has performed all conditions precedent.

WHEREFORE, Plaintiff demands judgment against Defendant for damages, costs, and such other relief as the Court deems just.

[Attorney Name]
Attorney for Plaintiff

---
*This document was generated using AI assistance and should be reviewed by a qualified attorney.*`;
  }

  generateContractReview(context) {
    return `CONTRACT REVIEW SUMMARY

EXECUTIVE SUMMARY
This contract review identifies key provisions, potential risks, and recommendations for improvement.

KEY PROVISIONS ANALYZED:
• Payment terms and conditions
• Termination and cancellation rights
• Liability and indemnification clauses
• Intellectual property provisions
• Governing law and dispute resolution

RISK ASSESSMENT: MEDIUM

MAJOR CONCERNS:
1. Termination clause heavily favors one party
2. Liability caps may be insufficient
3. Dispute resolution mechanism unclear

RECOMMENDATIONS:
1. Negotiate more balanced termination rights
2. Review and adjust liability limitations
3. Add clear arbitration clause
4. Include force majeure provisions
5. Clarify intellectual property ownership

NEXT STEPS:
• Schedule negotiation meeting
• Prepare redlined version
• Review with business stakeholders

---
*This review was generated using AI assistance and should be reviewed by a qualified attorney.*`;
  }

  async simulateDelay() {
    return new Promise(resolve =>
      setTimeout(resolve, this.responseDelay + Math.random() * 1000)
    );
  }

  // Check if demo mode is active
  isDemoMode() {
    return this.isDemo;
  }

  // Get available document types
  getAvailableDocumentTypes() {
    return [
      { id: 'demand-letter', name: 'Demand Letter', category: 'Litigation' },
      { id: 'settlement-agreement', name: 'Settlement Agreement', category: 'Litigation' },
      { id: 'motion-to-dismiss', name: 'Motion to Dismiss', category: 'Litigation' },
      { id: 'discovery-request', name: 'Discovery Request', category: 'Litigation' },
      { id: 'complaint', name: 'Complaint', category: 'Litigation' },
      { id: 'contract-review', name: 'Contract Review', category: 'Business' }
    ];
  }
}

export default new DemoAIService();