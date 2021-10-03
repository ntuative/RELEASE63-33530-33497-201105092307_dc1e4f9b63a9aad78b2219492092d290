package
{
   import com.sulake.habbo.communication.HabboCommunicationManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import mx.core.SimpleApplication;
   
   public class HabboCommunicationCom extends SimpleApplication
   {
      
      public static var manifest:Class = HabboCommunicationCom_manifest;
      
      public static var HabboCommunicationManager:Class = HabboCommunicationManager;
      
      public static var IIDHabboCommunicationManager:Class = IIDHabboCommunicationManager;
       
      
      public function HabboCommunicationCom()
      {
         super();
      }
   }
}
