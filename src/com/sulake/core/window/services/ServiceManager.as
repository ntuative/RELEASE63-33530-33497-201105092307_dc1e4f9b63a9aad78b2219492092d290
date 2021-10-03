package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContext;
   import flash.display.DisplayObject;
   
   public class ServiceManager implements IInternalWindowServices, IDisposable
   {
       
      
      private var var_2921:uint;
      
      private var var_149:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      private var var_255:IWindowContext;
      
      private var var_1123:IMouseDraggingService;
      
      private var var_1121:IMouseScalingService;
      
      private var var_1118:IMouseListenerService;
      
      private var var_1119:IFocusManagerService;
      
      private var var_1122:IToolTipAgentService;
      
      private var var_1120:IGestureAgentService;
      
      public function ServiceManager(param1:IWindowContext, param2:DisplayObject)
      {
         super();
         this.var_2921 = 0;
         this.var_149 = param2;
         this.var_255 = param1;
         this.var_1123 = new WindowMouseDragger(param2);
         this.var_1121 = new WindowMouseScaler(param2);
         this.var_1118 = new WindowMouseListener(param2);
         this.var_1119 = new FocusManager(param2);
         this.var_1122 = new WindowToolTipAgent(param2);
         this.var_1120 = new GestureAgentService();
      }
      
      public function dispose() : void
      {
         if(this.var_1123 != null)
         {
            this.var_1123.dispose();
            this.var_1123 = null;
         }
         if(this.var_1121 != null)
         {
            this.var_1121.dispose();
            this.var_1121 = null;
         }
         if(this.var_1118 != null)
         {
            this.var_1118.dispose();
            this.var_1118 = null;
         }
         if(this.var_1119 != null)
         {
            this.var_1119.dispose();
            this.var_1119 = null;
         }
         if(this.var_1122 != null)
         {
            this.var_1122.dispose();
            this.var_1122 = null;
         }
         if(this.var_1120 != null)
         {
            this.var_1120.dispose();
            this.var_1120 = null;
         }
         this.var_149 = null;
         this.var_255 = null;
         this._disposed = true;
      }
      
      public function getMouseDraggingService() : IMouseDraggingService
      {
         return this.var_1123;
      }
      
      public function getMouseScalingService() : IMouseScalingService
      {
         return this.var_1121;
      }
      
      public function getMouseListenerService() : IMouseListenerService
      {
         return this.var_1118;
      }
      
      public function getFocusManagerService() : IFocusManagerService
      {
         return this.var_1119;
      }
      
      public function getToolTipAgentService() : IToolTipAgentService
      {
         return this.var_1122;
      }
      
      public function getGestureAgentService() : IGestureAgentService
      {
         return this.var_1120;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
   }
}
