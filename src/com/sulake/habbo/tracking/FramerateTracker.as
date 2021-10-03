package com.sulake.habbo.tracking
{
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   
   public class FramerateTracker
   {
       
      
      private var var_1853:int;
      
      private var var_2540:int;
      
      private var var_818:int;
      
      private var var_536:Number;
      
      private var var_2541:Boolean;
      
      private var var_2539:int;
      
      private var var_1852:int;
      
      public function FramerateTracker()
      {
         super();
      }
      
      public function get frameRate() : int
      {
         return Math.round(1000 / this.var_536);
      }
      
      public function configure(param1:IHabboConfigurationManager) : void
      {
         this.var_2540 = int(param1.getKey("tracking.framerate.reportInterval.seconds","300")) * 1000;
         this.var_2539 = int(param1.getKey("tracking.framerate.maximumEvents","5"));
         this.var_2541 = true;
      }
      
      public function trackUpdate(param1:uint, param2:IHabboTracking, param3:int) : void
      {
         var _loc4_:Number = NaN;
         ++this.var_818;
         if(this.var_818 == 1)
         {
            this.var_536 = param1;
            this.var_1853 = param3;
         }
         else
         {
            _loc4_ = Number(this.var_818);
            this.var_536 = this.var_536 * (_loc4_ - 1) / _loc4_ + Number(param1) / _loc4_;
         }
         if(this.var_2541 && param3 - this.var_1853 >= this.var_2540)
         {
            this.var_818 = 0;
            if(this.var_1852 < this.var_2539)
            {
               param2.track("performance","averageFramerate",this.frameRate);
               ++this.var_1852;
               this.var_1853 = param3;
            }
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
