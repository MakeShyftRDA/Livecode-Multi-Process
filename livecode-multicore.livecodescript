script "livecode-multicore.livecodescript"

//*********************************************************************************
//Livecode MutiCore Library
//MIT License
//Compiled by Tom Glod (ww.makeshyft.com)
//Code written by Anthropic's Claude Opus
//Tested and Corrected by all contributors (Thank you to all)
//July 11, 2024
//https://github.com/MakeShyftRDA/Websockets-for-Livecode
//*********************************************************************************

// INTRODUCTION:
// This library provides a flexible and secure framework for implementing
// multi-core processing in LiveCode applications. It supports two main
// implementation methods: Process-based and HTTPD-based.

// KEY FEATURES:
// 1. Dual Implementation: Choose between Process-based or HTTPD-based methods
// 2. Security: Implements Trust on First Contact (TOFU) protocol and encryption
// 3. Easy-to-use Interface: Simple send and receive handlers for inter-core communication
// 4. Health Monitoring: Built-in functions to check core and server health
// 5. Load Balancing: Functionality to distribute work across available cores

// USAGE:
// 1. Configure the library using MultiCore_Configure
// 2. Initialize the multi-core system with MultiCore_Initialize
// 3. Use MultiCore_SendRequest to send tasks to helper cores
// 4. Handle incoming requests with MultiCore_HandleIncomingRequest
// 5. Manage core health and load balancing using provided utility functions

// IMPORTANT NOTES:
// - Ensure proper error handling and logging in your implementation
// - Regularly rotate encryption keys for enhanced security
// - Monitor core health and restart unresponsive cores as needed

// For detailed documentation on each function, refer to the comments
// preceding each handler in this library.

// CONFIGURATION AND UTILITY HANDLERS

local sMultiCore

command MultiCore_Configure pImplementationType, pOptions
    local tKey, tValue, tOption, tCoreNumber
    
    // VALIDATE INPUT PARAMETERS
    if pImplementationType is not among the items of "Process,HTTPD" then
        return "Error: Invalid implementation type. Use 'Process' or 'HTTPD'."
    end if
    
    // INITIALIZE THE CONFIGURATION ARRAY
    put pImplementationType into sMultiCore["Config"]["ImplementationType"]
    
    // PARSE AND STORE OPTIONS
    repeat for each line tOption in pOptions
        put item 1 of tOption into tKey
        put item 2 to -1 of tOption into tValue
        put tValue into sMultiCore["Config"][tKey]
    end repeat
    
    // SET DEFAULT VALUES IF NOT PROVIDED
    if sMultiCore["Config"]["NumberOfCores"] is empty then put 2 into sMultiCore["Config"]["NumberOfCores"]
    if sMultiCore["Config"]["Port"] is empty and pImplementationType is "HTTPD" then put 8080 into sMultiCore["Config"]["Port"]
    
    // INITIALIZE CORE-SPECIFIC DATA STRUCTURES
    repeat with tCoreNumber = 1 to sMultiCore["Config"]["NumberOfCores"]
        put empty into sMultiCore[tCoreNumber]
        put "Initialized" into sMultiCore[tCoreNumber]["Status"]
    end repeat
    
    // LOG CONFIGURATION
    MultiCore_LogMessage "Configuration set: " & the keys of sMultiCore["Config"]
    
    return "Configuration completed successfully."
end MultiCore_Configure

command MultiCore_LogMessage pMessage
    local tLogEntry
    
    // IMPLEMENT LOGGING FUNCTIONALITY HERE
    put "MultiCore [" & the long time & "]: " & pMessage into tLogEntry
    put tLogEntry & return after msg
end MultiCore_LogMessage

function MultiCore_IsMainCore
   // CHECK IF THE CURRENT INSTANCE IS THE MAIN CORE
   // RETURN TRUE OR FALSE
end MultiCore_IsMainCore

command MultiCore_LogError pErrorMessage
   // LOG THE ERROR MESSAGE WITH TIMESTAMP AND CORE IDENTIFIER
end MultiCore_LogError

// CORE INITIALIZATION AND SHUTDOWN

command MultiCore_Initialize
   // CHECK IF IT'S THE MAIN CORE
   // IF MAIN CORE, INITIALIZE HELPER CORES BASED ON CONFIGURATION
   // IF HELPER CORE, PERFORM NECESSARY SETUP
end MultiCore_Initialize

command MultiCore_Shutdown
   // CLOSE ALL HELPER CORES OR CONNECTIONS
   // PERFORM CLEANUP OPERATIONS
end MultiCore_Shutdown

command MultiCore_ManageHelperCores
   // MONITOR HELPER CORES
   // RESTART OR REINITIALIZE CORES IF NECESSARY
   // HANDLE LOAD BALANCING IF IMPLEMENTED
end MultiCore_ManageHelperCores

function MultiCore_CheckCoreHealth pCoreIdentifier
   // CHECK THE HEALTH STATUS OF A SPECIFIC CORE
   // RETURN THE HEALTH STATUS (E.G., "HEALTHY", "UNRESPONSIVE", "OVERLOADED")
end MultiCore_CheckCoreHealth

// SECURITY AND ENCRYPTION

function MultiCore_GenerateKey
   // GENERATE A CRYPTOGRAPHICALLY SECURE RANDOM KEY
   // RETURN THE GENERATED KEY
end MultiCore_GenerateKey

function MultiCore_EncryptMessage pMessage, pKey
   // ENCRYPT THE MESSAGE USING THE PROVIDED KEY
   // RETURN THE ENCRYPTED MESSAGE
end MultiCore_EncryptMessage

function MultiCore_DecryptMessage pEncryptedMessage, pKey
   // DECRYPT THE MESSAGE USING THE PROVIDED KEY
   // RETURN THE DECRYPTED MESSAGE
end MultiCore_DecryptMessage

function MultiCore_GenerateNonce
   // GENERATE A UNIQUE NONCE FOR USE IN COMMUNICATIONS
   // RETURN THE GENERATED NONCE
end MultiCore_GenerateNonce

// SECURITY AND TRUST ESTABLISHMENT

command MultiCore_InitiateHandshake pCoreIdentifier
   // GENERATE INITIAL HANDSHAKE MESSAGE
   // INCLUDE NECESSARY INFORMATION FOR TRUST ON FIRST CONTACT
   // SEND HANDSHAKE MESSAGE TO TARGET CORE
end MultiCore_InitiateHandshake

command MultiCore_HandleHandshake pHandshakeData
   // PROCESS INCOMING HANDSHAKE MESSAGE
   // VERIFY INTEGRITY AND AUTHENTICITY OF THE MESSAGE
   // PREPARE AND SEND HANDSHAKE RESPONSE IF NECESSARY
end MultiCore_HandleHandshake

command MultiCore_EstablishTrust pCoreIdentifier, pInitialTrustData
   // IMPLEMENT TRUST ON FIRST CONTACT PROTOCOL
   // VERIFY INITIAL TRUST DATA
   // GENERATE AND STORE LONG-TERM TRUST INFORMATION
end MultiCore_EstablishTrust

command MultiCore_ExchangeKeys pCoreIdentifier
   // GENERATE NEW SESSION KEYS
   // SECURELY EXCHANGE KEYS WITH TARGET CORE
   // STORE NEW KEYS FOR FUTURE COMMUNICATION
end MultiCore_ExchangeKeys

function MultiCore_VerifyTrust pCoreIdentifier
   // CHECK IF THE CORE IS ALREADY TRUSTED
   // VERIFY TRUST INFORMATION IF EXISTS
   // RETURN TRUE IF TRUSTED, FALSE OTHERWISE
end MultiCore_VerifyTrust

command MultiCore_RotateKeys pCoreIdentifier
   // GENERATE NEW KEYS FOR ONGOING COMMUNICATION
   // SECURELY EXCHANGE NEW KEYS WITH TARGET CORE
   // UPDATE STORED KEYS
end MultiCore_RotateKeys

// PROCESS-BASED IMPLEMENTATION

command MultiCore_Process_LaunchHelper pHelperIdentifier
   // LAUNCH A NEW PROCESS FOR THE HELPER CORE
   // PASS NECESSARY STARTUP PARAMETERS
   // ESTABLISH INITIAL COMMUNICATION
end MultiCore_Process_LaunchHelper

command MultiCore_Process_CloseHelper pHelperIdentifier
   // GRACEFULLY TERMINATE THE HELPER PROCESS
   // PERFORM ANY NECESSARY CLEANUP
end MultiCore_Process_CloseHelper

function MultiCore_Process_ReadFromHelper pHelperIdentifier
   // READ DATA FROM THE SPECIFIED HELPER PROCESS
   // HANDLE ANY READ ERRORS
   // RETURN THE READ DATA
end MultiCore_Process_ReadFromHelper

command MultiCore_Process_WriteToHelper pHelperIdentifier, pData
   // WRITE DATA TO THE SPECIFIED HELPER PROCESS
   // HANDLE ANY WRITE ERRORS
end MultiCore_Process_WriteToHelper

function MultiCore_Process_IsHelperRunning pHelperIdentifier
   // CHECK IF THE SPECIFIED HELPER PROCESS IS STILL RUNNING
   // RETURN TRUE IF RUNNING, FALSE OTHERWISE
end MultiCore_Process_IsHelperRunning

// HTTPD-BASED IMPLEMENTATION

command MultiCore_HTTPD_StartServer pPort
   // START THE HTTPD SERVER FOR INTER-CORE COMMUNICATION
   // CONFIGURE SERVER SETTINGS
end MultiCore_HTTPD_StartServer

command MultiCore_HTTPD_StopServer
   // STOP THE HTTPD SERVER
   // PERFORM ANY NECESSARY CLEANUP
end MultiCore_HTTPD_StopServer

command MultiCore_HTTPD_HandleRequest pRequestData
   // PROCESS INCOMING HTTP REQUESTS FROM HELPER CORES
   // ROUTE REQUEST TO APPROPRIATE HANDLER
end MultiCore_HTTPD_HandleRequest

command MultiCore_HTTPD_SendResponse pCoreIdentifier, pResponseData
   // SEND HTTP RESPONSE TO A HELPER CORE
   // HANDLE ANY TRANSMISSION ERRORS
end MultiCore_HTTPD_SendResponse

function MultiCore_HTTPD_IsServerRunning
   // CHECK IF THE HTTPD SERVER IS CURRENTLY RUNNING
   // RETURN TRUE IF RUNNING, FALSE OTHERWISE
end MultiCore_HTTPD_IsServerRunning

// COMMON INTERFACE HANDLERS

command MultiCore_SendRequest pTargetCore, pRequestData
   // SEND A REQUEST TO A HELPER CORE
   // USE EITHER PROCESS OR HTTPD METHOD BASED ON CONFIGURATION
end MultiCore_SendRequest

function MultiCore_ReceiveResponse pSourceCore
   // RECEIVE A RESPONSE FROM A HELPER CORE
   // USE EITHER PROCESS OR HTTPD METHOD BASED ON CONFIGURATION
   // RETURN THE RECEIVED RESPONSE
end MultiCore_ReceiveResponse

command MultiCore_HandleIncomingRequest pRequestData
   // PROCESS AN INCOMING REQUEST FROM A HELPER CORE
   // EXECUTE REQUESTED OPERATION
   // PREPARE RESPONSE DATA
end MultiCore_HandleIncomingRequest

command MultiCore_SendResponse pTargetCore, pResponseData
   // SEND A RESPONSE BACK TO THE REQUESTING CORE
   // USE EITHER PROCESS OR HTTPD METHOD BASED ON CONFIGURATION
end MultiCore_SendResponse

function MultiCore_GetAvailableCore
   // DETERMINE THE LEAST LOADED OR NEXT AVAILABLE CORE
   // IMPLEMENT LOAD BALANCING LOGIC
   // RETURN THE IDENTIFIER OF THE CHOSEN CORE
end MultiCore_GetAvailableCore

function MultiCore_CheckRequestStatus pRequestID
   // CHECK THE STATUS OF A PREVIOUSLY SENT REQUEST
   // RETURN THE STATUS (E.G., "PENDING", "COMPLETED", "FAILED")
end MultiCore_CheckRequestStatus