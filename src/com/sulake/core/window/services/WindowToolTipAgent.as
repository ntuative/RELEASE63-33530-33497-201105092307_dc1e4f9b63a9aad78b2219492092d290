package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IToolTipWindow;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowType;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService
   {
       
      
      protected var var_1324:String;
      
      protected var var_284:IToolTipWindow;
      
      protected var var_405:Timer;
      
      protected var var_1326:Point;
      
      protected var var_1325:Point;
      
      protected var var_1603:uint;
      
      public function WindowToolTipAgent(param1:DisplayObject)
      {
         this.var_1325 = new Point();
         this.var_1326 = new Point(20,20);
         this.var_1603 = 500;
         super(param1);
      }
      
      override public function begin(param1:IWindow, param2:uint = 0) : IWindow
      {
         if(param1 && !param1.disposed)
         {
            if(param1 is IInteractiveWindow)
            {
               this.var_1324 = IInteractiveWindow(param1).toolTipCaption;
               this.var_1603 = IInteractiveWindow(param1).toolTipDelay;
            }
            else
            {
               this.var_1324 = param1.caption;
               this.var_1603 = 500;
            }
            _mouse.x = var_149.mouseX;
            _mouse.y = var_149.mouseY;
            getMousePositionRelativeTo(param1,_mouse,this.var_1325);
            if(this.var_1324 != null && this.var_1324 != "")
            {
               if(this.var_405 == null)
               {
                  this.var_405 = new Timer(this.var_1603,1);
                  this.var_405.addEventListener(TimerEvent.TIMER,this.showToolTip);
               }
               this.var_405.reset();
               this.var_405.start();
            }
         }
         return super.begin(param1,param2);
      }
      
      override public function end(param1:IWindow) : IWindow
      {
         if(this.var_405 != null)
         {
            this.var_405.stop();
            this.var_405.removeEventListener(TimerEvent.TIMER,this.showToolTip);
            this.var_405 = null;
         }
         this.hideToolTip();
         return super.end(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         if(_window && true)
         {
            _mouse.x = param1;
            _mouse.y = param2;
            getMousePositionRelativeTo(_window,_mouse,this.var_1325);
            if(this.var_284 != null && !this.var_284.disposed)
            {
               this.var_284.x = param1 + this.var_1326.x;
               this.var_284.y = param2 + this.var_1326.y;
            }
         }
      }
      
      protected function showToolTip(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         if(this.var_405 != null)
         {
            this.var_405.reset();
         }
         if(_window && true)
         {
            if(this.var_284 == null || this.var_284.disposed)
            {
               this.var_284 = _window.context.create("undefined::ToolTip",this.var_1324,WindowType.const_417,_window.style,0 | 0,null,null,null,0,null,null) as IToolTipWindow;
            }
            _loc2_ = new Point();
            _window.getGlobalPosition(_loc2_);
            this.var_284.x = _loc2_.x + this.var_1325.x + this.var_1326.x;
            this.var_284.y = _loc2_.y + this.var_1325.y + this.var_1326.y;
         }
      }
      
      protected function hideToolTip() : void
      {
         if(this.var_284 != null && !this.var_284.disposed)
         {
            this.var_284.destroy();
            this.var_284 = null;
         }
      }
   }
}
