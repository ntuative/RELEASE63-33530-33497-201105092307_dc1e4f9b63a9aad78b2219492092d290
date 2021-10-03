package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class OutfitView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _window:IWindowContainer;
      
      private var var_456:IBitmapWrapperWindow;
      
      public function OutfitView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:Boolean)
      {
         super();
         this._windowManager = param1;
         this._assetLibrary = param2;
         var _loc4_:XmlAsset = this._assetLibrary.getAssetByName("Outfit") as XmlAsset;
         this._window = IWindowContainer(this._windowManager.buildFromXML(_loc4_.content as XML));
         if(this._window != null)
         {
            this.var_456 = this._window.findChildByName("bitmap") as IBitmapWrapperWindow;
         }
         if(!param3)
         {
            this._window.findChildByName("button").disable();
         }
      }
      
      public function dispose() : void
      {
         this._windowManager = null;
         this._assetLibrary = null;
         if(this._window)
         {
            this._window.dispose();
         }
         this._window = null;
         if(this.var_456)
         {
            this.var_456.dispose();
         }
         this.var_456 = null;
      }
      
      public function udpate(param1:BitmapData) : void
      {
         this.var_456.bitmap = new BitmapData(this.var_456.width,this.var_456.height,true,16777215);
         var _loc2_:int = (this.var_456.width - param1.width) / 2;
         var _loc3_:int = this.var_456.height - param1.height;
         this.var_456.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
      }
      
      public function get window() : IWindowContainer
      {
         return this._window;
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            Logger.log("[OutfitView] Click! This should be over-ridden!");
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            this._window.color = 13421772;
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            this._window.color = 6710886;
         }
      }
   }
}
