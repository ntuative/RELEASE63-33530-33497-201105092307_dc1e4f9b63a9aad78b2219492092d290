package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   
   public class WindowEvent
   {
      
      public static const const_1665:String = "WE_DESTROY";
      
      public static const const_327:String = "WE_DESTROYED";
      
      public static const const_1621:String = "WE_OPEN";
      
      public static const const_1655:String = "WE_OPENED";
      
      public static const const_1578:String = "WE_CLOSE";
      
      public static const const_1663:String = "WE_CLOSED";
      
      public static const const_1771:String = "WE_FOCUS";
      
      public static const const_349:String = "WE_FOCUSED";
      
      public static const const_1838:String = "WE_UNFOCUS";
      
      public static const const_1740:String = "WE_UNFOCUSED";
      
      public static const const_1614:String = "WE_ACTIVATE";
      
      public static const const_516:String = "WE_ACTIVATED";
      
      public static const const_1644:String = "WE_DEACTIVATE";
      
      public static const const_543:String = "WE_DEACTIVATED";
      
      public static const const_353:String = "WE_SELECT";
      
      public static const const_57:String = "WE_SELECTED";
      
      public static const const_500:String = "WE_UNSELECT";
      
      public static const const_481:String = "WE_UNSELECTED";
      
      public static const const_1871:String = "WE_LOCK";
      
      public static const const_1856:String = "WE_LOCKED";
      
      public static const const_1706:String = "WE_UNLOCK";
      
      public static const const_1834:String = "WE_UNLOCKED";
      
      public static const const_977:String = "WE_ENABLE";
      
      public static const const_254:String = "WE_ENABLED";
      
      public static const const_826:String = "WE_DISABLE";
      
      public static const const_273:String = "WE_DISABLED";
      
      public static const WINDOW_EVENT_RELOCATE:String = "WE_RELOCATE";
      
      public static const const_329:String = "WE_RELOCATED";
      
      public static const const_1319:String = "WE_RESIZE";
      
      public static const const_41:String = "WE_RESIZED";
      
      public static const const_1618:String = "WE_MINIMIZE";
      
      public static const const_1658:String = "WE_MINIMIZED";
      
      public static const const_1611:String = "WE_MAXIMIZE";
      
      public static const const_1836:String = "WE_MAXIMIZED";
      
      public static const const_1876:String = "WE_RESTORE";
      
      public static const const_1668:String = "WE_RESTORED";
      
      public static const const_577:String = "WE_CHILD_ADDED";
      
      public static const const_382:String = "WE_CHILD_REMOVED";
      
      public static const const_211:String = "WE_CHILD_RELOCATED";
      
      public static const const_141:String = "WE_CHILD_RESIZED";
      
      public static const const_346:String = "WE_CHILD_ACTIVATED";
      
      public static const const_489:String = "WE_PARENT_ADDED";
      
      public static const const_1593:String = "WE_PARENT_REMOVED";
      
      public static const const_1766:String = "WE_PARENT_RELOCATED";
      
      public static const const_798:String = "WE_PARENT_RESIZED";
      
      public static const const_1249:String = "WE_PARENT_ACTIVATED";
      
      public static const const_183:String = "WE_OK";
      
      public static const const_545:String = "WE_CANCEL";
      
      public static const const_103:String = "WE_CHANGE";
      
      public static const const_595:String = "WE_SCROLL";
      
      public static const const_184:String = "";
      
      private static const POOL:Array = [];
       
      
      protected var _type:String;
      
      protected var _window:IWindow;
      
      protected var var_696:IWindow;
      
      protected var var_1069:Boolean;
      
      protected var var_471:Boolean;
      
      protected var var_480:Boolean;
      
      protected var var_695:Array;
      
      public function WindowEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false) : WindowEvent
      {
         var _loc5_:WindowEvent = POOL.length > 0 ? POOL.pop() : new WindowEvent();
         _loc5_._type = param1;
         _loc5_._window = param2;
         _loc5_.var_696 = param3;
         _loc5_.var_471 = param4;
         _loc5_.var_480 = false;
         _loc5_.var_695 = POOL;
         return _loc5_;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get target() : IWindow
      {
         return this._window;
      }
      
      public function get window() : IWindow
      {
         return this._window;
      }
      
      public function get related() : IWindow
      {
         return this.var_696;
      }
      
      public function get cancelable() : Boolean
      {
         return this.var_471;
      }
      
      public function recycle() : void
      {
         if(this.var_480)
         {
            throw new Error("Event already recycled!");
         }
         this.var_696 = null;
         this._window = null;
         this.var_480 = true;
         this.var_1069 = false;
         this.var_695.push(this);
      }
      
      public function clone() : WindowEvent
      {
         return allocate(this._type,this.window,this.related,this.cancelable);
      }
      
      public function preventDefault() : void
      {
         this.preventWindowOperation();
      }
      
      public function isDefaultPrevented() : Boolean
      {
         return this.var_1069;
      }
      
      public function preventWindowOperation() : void
      {
         if(this.cancelable)
         {
            this.var_1069 = true;
            return;
         }
         throw new Error("Attempted to prevent window operation that is not cancelable!");
      }
      
      public function isWindowOperationPrevented() : Boolean
      {
         return this.var_1069;
      }
      
      public function stopPropagation() : void
      {
         this.var_1069 = true;
      }
      
      public function stopImmediatePropagation() : void
      {
         this.var_1069 = true;
      }
      
      public function toString() : String
      {
         return "WindowEvent { type: " + this._type + " cancelable: " + this.var_471 + " window: " + this._window + " }";
      }
   }
}
