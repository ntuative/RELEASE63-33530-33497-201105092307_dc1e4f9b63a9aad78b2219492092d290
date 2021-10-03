package
{
   import com.sulake.core.communication.CoreCommunicationManager;
   import com.sulake.iid.IIDCoreCommunicationManager;
   import mx.core.SimpleApplication;
   
   public class CoreCommunicationFrameworkLib extends SimpleApplication
   {
      
      public static var manifest:Class = CoreCommunicationFrameworkLib_manifest;
      
      public static var CoreCommunicationManager:Class = CoreCommunicationManager;
      
      public static var IIDCoreCommunicationManager:Class = IIDCoreCommunicationManager;
       
      
      public function CoreCommunicationFrameworkLib()
      {
         super();
      }
   }
}
