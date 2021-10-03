package
{
   import com.sulake.habbo.advertisement.AdManager;
   import com.sulake.iid.IIDHabboAdManager;
   import mx.core.SimpleApplication;
   
   public class HabboAdManagerCom extends SimpleApplication
   {
      
      public static var manifest:Class = HabboAdManagerCom_manifest;
      
      public static var AdManager:Class = AdManager;
      
      public static var IIDHabboAdManager:Class = IIDHabboAdManager;
       
      
      public function HabboAdManagerCom()
      {
         super();
      }
   }
}
