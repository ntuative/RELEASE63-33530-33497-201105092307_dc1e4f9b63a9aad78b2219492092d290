package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.enum.WindowState;
   import flash.geom.Rectangle;
   
   public class WindowToggle implements IDisposable
   {
      
      public static const RESULT_SHOW:int = 0;
      
      public static const const_1730:int = 1;
      
      public static const const_1211:int = 2;
       
      
      private var _window:IWindow;
      
      private var var_1042:IDesktopWindow;
      
      private var _disposed:Boolean;
      
      private var var_1576:Function;
      
      private var var_1043:Function;
      
      public function WindowToggle(param1:IWindow, param2:IDesktopWindow, param3:Function = null, param4:Function = null)
      {
         super();
         this._window = param1;
         this.var_1042 = param2;
         this.var_1576 = param3;
         this.var_1043 = param4;
      }
      
      public static function isHiddenByOtherWindows(param1:IWindow) : Boolean
      {
         var _loc7_:* = null;
         var _loc2_:IDesktopWindow = param1.desktop;
         var _loc3_:int = _loc2_.numChildren;
         var _loc4_:int = _loc2_.getChildIndex(param1);
         if(_loc4_ < 0)
         {
            throw new Error("Window must be contained by the desktop!");
         }
         var _loc5_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc5_);
         var _loc6_:Rectangle = new Rectangle();
         var _loc8_:int = _loc4_ + 1;
         while(_loc8_ < _loc3_)
         {
            _loc7_ = _loc2_.getChildAt(_loc8_);
            if(_loc7_.visible)
            {
               _loc7_.getGlobalRectangle(_loc6_);
               if(_loc5_.intersects(_loc6_))
               {
                  return true;
               }
            }
            _loc8_++;
         }
         return false;
      }
      
      public function get window() : IWindow
      {
         return this._window;
      }
      
      public function get visible() : Boolean
      {
         return this._window && this._window.visible && this._window.parent;
      }
      
      public function get active() : Boolean
      {
         return this.visible && this._window.getStateFlag(WindowState.const_88);
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            if(this._window)
            {
               this._window.dispose();
               this._window = null;
            }
            this.var_1042 = null;
            this._disposed = true;
            this.var_1576 = null;
            this.var_1043 = null;
         }
      }
      
      public function show() : void
      {
         if(!this._window.disposed)
         {
            if(this._window.parent != this.var_1042)
            {
               this.var_1042.addChild(this._window);
            }
            if(!this._window.visible)
            {
               this._window.visible = true;
            }
            this._window.activate();
         }
      }
      
      public function hide() : void
      {
         if(!this._window.disposed)
         {
            if(this._window.parent == this.var_1042)
            {
               this.var_1042.removeChild(this._window);
            }
            if(this._window.visible)
            {
               this._window.visible = false;
            }
            this._window.deactivate();
         }
      }
      
      public function toggle() : int
      {
         if(this.visible)
         {
            if(this.active)
            {
               if(this.var_1043 == null)
               {
                  this.hide();
               }
               else
               {
                  this.var_1043.call();
               }
               return const_1211;
            }
            if(isHiddenByOtherWindows(this._window))
            {
               this._window.activate();
               return const_1730;
            }
            if(this.var_1043 == null)
            {
               this.hide();
            }
            else
            {
               this.var_1043.call();
            }
            return const_1211;
         }
         if(this.var_1576 == null)
         {
            this.show();
         }
         else
         {
            this.var_1576.call();
         }
         return RESULT_SHOW;
      }
   }
}
