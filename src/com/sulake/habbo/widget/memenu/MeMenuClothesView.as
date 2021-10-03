package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetAvatarEditorMessage;
   import flash.geom.Point;
   
   public class MeMenuClothesView implements IMeMenuView
   {
      
      private static const const_1384:Point = new Point(100,20);
       
      
      private var _widget:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      public function MeMenuClothesView()
      {
         super();
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         this._widget = param1;
         this.createWindow(param2);
      }
      
      public function dispose() : void
      {
         if(this._widget && this._widget.messageListener)
         {
            this._widget.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage(RoomWidgetAvatarEditorMessage.const_721));
         }
         this._widget = null;
         if(this._window.numChildren > 0)
         {
            this._window.removeChildAt(0);
         }
         this._window.dispose();
         this._window = null;
      }
      
      public function get window() : IWindowContainer
      {
         return this._window;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:XmlAsset = this._widget.assets.getAssetByName("memenu_clothes") as XmlAsset;
         this._window = this._widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(this._window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         this._window.name = param1;
         this._widget.mainContainer.addChild(this._window);
         this._widget.mainContainer.position = const_1384;
         this._window.addEventListener(WindowEvent.const_141,this.onChildResized);
         this._widget.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage(RoomWidgetAvatarEditorMessage.const_440,this._window));
      }
      
      private function onChildResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = this._window.getChildAt(0);
         if(!_loc2_)
         {
            return;
         }
         this._window.width = _loc2_.width;
         this._widget.updateSize();
      }
   }
}
