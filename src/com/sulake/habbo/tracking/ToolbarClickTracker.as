package com.sulake.habbo.tracking
{
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   
   public class ToolbarClickTracker
   {
       
      
      private var var_1337:IHabboTracking;
      
      private var var_1987:Boolean = false;
      
      private var var_2489:int = 0;
      
      private var var_1829:int = 0;
      
      public function ToolbarClickTracker(param1:IHabboTracking)
      {
         super();
         this.var_1337 = param1;
      }
      
      public function dispose() : void
      {
         this.var_1337 = null;
      }
      
      public function configure(param1:IHabboConfigurationManager) : void
      {
         this.var_1987 = Boolean(parseInt(param1.getKey("toolbar.tracking.enabled","1")));
         this.var_2489 = parseInt(param1.getKey("toolbar.tracking.max.events","100"));
      }
      
      public function track(param1:String) : void
      {
         if(!this.var_1987)
         {
            return;
         }
         ++this.var_1829;
         if(this.var_1829 <= this.var_2489)
         {
            this.var_1337.track("toolbar",param1);
         }
      }
   }
}
