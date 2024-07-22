/** example code für Demo von Flow - Nicht auf HF Dev kopieren! **/

public class GenericValueExtractionHandler_DoNotUse {
    // Define a class for the method's input.
    public class Request {
        @InvocableVariable(required=true)
        public Id accountId;
    }
    
    // Define a class for the method's output.
    public class Response {
        @InvocableVariable
        public String accountId;
        
        @InvocableVariable
        public String accountName;
        
        @InvocableVariable
        public String phone;
    }
    
    @InvocableMethod(label='GenericValueExtractionHandler - Demo, nicht benutzen!' description='Returns Name and Phone for a list of Accounts')
    public static List<Response> fetchAccountInfo(List<Request> requests) {
        // Extract Account IDs from the inputs
        List<Id> accountIds = new List<Id>();
        for(Request request : requests) {
            accountIds.add(request.accountId);
        }
        
        // Query the Accounts for their Name and Phone
        List<Account> accounts = [SELECT Id, Name, Phone FROM Account WHERE Id IN :accountIds];
        
        // Prepare and return the response
        List<Response> responses = new List<Response>();
        for(Account acc : accounts) {
            Response resp = new Response();
            resp.accountId = acc.Id;
            resp.accountName = acc.Name;
            resp.phone = acc.Phone;
            responses.add(resp);
        }
        
        return responses;
    }
}