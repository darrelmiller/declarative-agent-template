import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-copilot-skills";

using TypeSpec.Http;
using TypespecCopilotSkills;
using TypespecCopilotSkills.Agents;

@agent(
    "<AgentName>",
    "<Agent Description>",
)
@instructions(
    "<Instructions>"
)
namespace MyTypeSpecAgent {

   op WebSearch is AgentCapabilities.WebSearch;

}
