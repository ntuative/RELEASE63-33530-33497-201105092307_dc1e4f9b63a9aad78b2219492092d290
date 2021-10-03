package com.sulake.core.window.utils.tablet
{
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.MouseEventProcessor;
   
   public class TabletEventProcessor extends MouseEventProcessor
   {
       
      
      private var var_2977:String = "";
      
      public function TabletEventProcessor()
      {
         super();
      }
      
      override public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         if(param2.length == 0)
         {
            return;
         }
         var_81 = param1.desktop;
         var_60 = param1.var_1314 as WindowController;
         var_172 = param1.var_1313 as WindowController;
         var_164 = param1.renderer;
         var_858 = param1.var_1310;
         param2.begin();
         param2.end();
         param1.desktop = var_81;
         param1.var_1314 = var_60;
         param1.var_1313 = var_172;
         param1.renderer = var_164;
         param1.var_1310 = var_858;
      }
   }
}
