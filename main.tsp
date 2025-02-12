import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-copilot-skills";

using TypeSpec.Http;
using TypespecCopilotSkills;
using TypespecCopilotSkills.Agents;


/** Agent Asteroid knows everything about Earth close-approach small-body objects */
@agent(
    "ACoolAgent",
    "It is an agent that does something",    
)
@instructions(
    "This agent is capable of searching for guidelines on the Microsoft API Guidelines GitHub repository"
)
namespace MyTypeSpecAgent {

   op SearchGuidelines is AgentCapabilities.WebSearch<{ url: "https://github.com/microsoft/api-guidelines"}>;

   op SearchSharePoint is AgentCapabilities.OneDriveAndSharePoint<{ itemsByUrl: [{url:"https://microsoft.sharepoint.com/sites/Graph"}] }>;

}
