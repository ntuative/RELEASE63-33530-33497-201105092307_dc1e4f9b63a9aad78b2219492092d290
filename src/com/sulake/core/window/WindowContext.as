package com.sulake.core.window
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.components.DesktopController;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.SubstituteParentController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import com.sulake.core.window.services.IInternalWindowServices;
   import com.sulake.core.window.services.ServiceManager;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventProcessor;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.IWindowParser;
   import com.sulake.core.window.utils.MouseEventProcessor;
   import com.sulake.core.window.utils.MouseEventQueue;
   import com.sulake.core.window.utils.WindowParser;
   import com.sulake.core.window.utils.tablet.TabletEventProcessor;
   import com.sulake.core.window.utils.tablet.TabletEventQueue;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class WindowContext implements IWindowContext, IDisposable, IUpdateReceiver
   {
      
      public static const const_507:uint = 0;
      
      public static const const_1849:uint = 1;
      
      public static const const_2105:int = 0;
      
      public static const const_2040:int = 1;
      
      public static const const_1947:int = 2;
      
      public static const const_1962:int = 3;
      
      public static const const_1737:int = 4;
      
      public static const const_378:int = 5;
      
      public static var var_400:IEventQueue;
      
      private static var var_604:IEventProcessor;
      
      private static var var_1718:uint = const_507;
      
      private static var stage:Stage;
      
      private static var var_164:IWindowRenderer;
       
      
      private var var_2335:EventProcessorState;
      
      private var var_2336:IWindowContextStateListener;
      
      protected var _localization:ICoreLocalizationManager;
      
      protected var var_129:DisplayObjectContainer;
      
      protected var var_2957:Boolean = true;
      
      protected var var_1317:Error;
      
      protected var var_2122:int = -1;
      
      protected var var_1318:IInternalWindowServices;
      
      protected var var_1601:IWindowParser;
      
      protected var var_2902:IWindowFactory;
      
      protected var var_81:IDesktopWindow;
      
      protected var var_1602:SubstituteParentController;
      
      private var _disposed:Boolean = false;
      
      private var var_568:Boolean = false;
      
      private var var_2334:Boolean = false;
      
      private var _name:String;
      
      public function WindowContext(param1:String, param2:IWindowRenderer, param3:IWindowFactory, param4:ICoreLocalizationManager, param5:DisplayObjectContainer, param6:Rectangle, param7:IWindowContextStateListener)
      {
         super();
         this._name = param1;
         var_164 = param2;
         this._localization = param4;
         this.var_129 = param5;
         this.var_1318 = new ServiceManager(this,param5);
         this.var_2902 = param3;
         this.var_1601 = new WindowParser(this);
         this.var_2336 = param7;
         if(!stage)
         {
            if(this.var_129 is Stage)
            {
               stage = this.var_129 as Stage;
            }
            else if(this.var_129.stage)
            {
               stage = this.var_129.stage;
            }
         }
         Classes.init();
         if(param6 == null)
         {
            param6 = new Rectangle(0,0,800,600);
         }
         this.var_81 = new DesktopController("_CONTEXT_DESKTOP_" + this._name,this,param6);
         this.var_81.limits.maxWidth = param6.width;
         this.var_81.limits.maxHeight = param6.height;
         this.var_129.addChild(this.var_81.getDisplayObject());
         this.var_129.doubleClickEnabled = true;
         this.var_129.addEventListener(Event.RESIZE,this.stageResizedHandler);
         this.var_2335 = new EventProcessorState(var_164,this.var_81,this.var_81,null,this.var_2336);
         inputMode = const_507;
         this.var_1602 = new SubstituteParentController(this);
      }
      
      public static function get inputMode() : uint
      {
         return var_1718;
      }
      
      public static function set inputMode(param1:uint) : void
      {
         var value:uint = param1;
         if(var_400)
         {
            if(var_400 is IDisposable)
            {
               IDisposable(var_400).dispose();
            }
         }
         if(var_604)
         {
            if(var_604 is IDisposable)
            {
               IDisposable(var_604).dispose();
            }
         }
         switch(value)
         {
            case const_507:
               var_400 = new MouseEventQueue(stage);
               var_604 = new MouseEventProcessor();
               try
               {
               }
               catch(e:Error)
               {
               }
               break;
            case const_1849:
               var_400 = new TabletEventQueue(stage);
               var_604 = new TabletEventProcessor();
               try
               {
               }
               catch(e:Error)
               {
               }
               break;
            default:
               inputMode = const_507;
               throw new Error("Unknown input mode " + value);
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this._disposed = true;
            this.var_129.removeEventListener(Event.RESIZE,this.stageResizedHandler);
            this.var_129.removeChild(IGraphicContextHost(this.var_81).getGraphicContext(true) as DisplayObject);
            this.var_81.destroy();
            this.var_81 = null;
            this.var_1602.destroy();
            this.var_1602 = null;
            if(this.var_1318 is IDisposable)
            {
               IDisposable(this.var_1318).dispose();
            }
            this.var_1318 = null;
            this.var_1601.dispose();
            this.var_1601 = null;
            var_164 = null;
         }
      }
      
      public function getLastError() : Error
      {
         return this.var_1317;
      }
      
      public function getLastErrorCode() : int
      {
         return this.var_2122;
      }
      
      public function handleError(param1:int, param2:Error) : void
      {
         this.var_1317 = param2;
         this.var_2122 = param1;
         if(this.var_2957)
         {
            throw param2;
         }
      }
      
      public function method_11() : void
      {
         this.var_1317 = null;
         this.var_2122 = -1;
      }
      
      public function getWindowServices() : IInternalWindowServices
      {
         return this.var_1318;
      }
      
      public function getWindowParser() : IWindowParser
      {
         return this.var_1601;
      }
      
      public function getWindowFactory() : IWindowFactory
      {
         return this.var_2902;
      }
      
      public function getDesktopWindow() : IDesktopWindow
      {
         return this.var_81;
      }
      
      public function findWindowByName(param1:String) : IWindow
      {
         return this.var_81.findChildByName(param1);
      }
      
      public function registerLocalizationListener(param1:String, param2:IWindow) : void
      {
         this._localization.registerListener(param1,param2 as ILocalizable);
      }
      
      public function removeLocalizationListener(param1:String, param2:IWindow) : void
      {
         this._localization.removeListener(param1,param2 as ILocalizable);
      }
      
      public function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array = null, param11:Array = null) : IWindow
      {
         var _loc12_:* = null;
         var _loc13_:Class = Classes.getWindowClassByType(param3);
         if(_loc13_ == null)
         {
            this.handleError(WindowContext.const_1737,new Error("Failed to solve implementation for window \"" + param1 + "\"!"));
            return null;
         }
         if(param8 == null)
         {
            if(param5 & 0)
            {
               param8 = this.var_1602;
            }
         }
         _loc12_ = new _loc13_(param1,param3,param4,param5,this,param6,param8 != null ? param8 : this.var_81,param7,param10,param11,param9);
         if(param2 && param2.length)
         {
            _loc12_.caption = param2;
         }
         return _loc12_;
      }
      
      public function destroy(param1:IWindow) : Boolean
      {
         if(param1 == this.var_81)
         {
            this.var_81 = null;
         }
         if(param1.state != WindowState.const_571)
         {
            param1.destroy();
         }
         return true;
      }
      
      public function invalidate(param1:IWindow, param2:Rectangle, param3:uint) : void
      {
         if(!this.disposed)
         {
            var_164.addToRenderQueue(WindowController(param1),param2,param3);
         }
      }
      
      public function update(param1:uint) : void
      {
         this.var_568 = true;
         if(this.var_1317)
         {
            throw this.var_1317;
         }
         var_604.process(this.var_2335,var_400);
         this.var_568 = false;
      }
      
      public function render(param1:uint) : void
      {
         this.var_2334 = true;
         var_164.update(param1);
         this.var_2334 = false;
      }
      
      private function stageResizedHandler(param1:Event) : void
      {
         if(this.var_81 != null && !this.var_81.disposed)
         {
            if(this.var_129 is Stage)
            {
               this.var_81.limits.maxWidth = Stage(this.var_129).stageWidth;
               this.var_81.limits.maxHeight = Stage(this.var_129).stageHeight;
               this.var_81.width = Stage(this.var_129).stageWidth;
               this.var_81.height = Stage(this.var_129).stageHeight;
            }
            else
            {
               this.var_81.limits.maxWidth = this.var_129.width;
               this.var_81.limits.maxHeight = this.var_129.height;
               this.var_81.width = this.var_129.width;
               this.var_81.height = this.var_129.height;
            }
         }
      }
   }
}
