package com.sulake.habbo.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridItem
   {
      
      public static const const_585:int = 0;
      
      public static const const_1237:int = 1;
      
      public static const const_1291:int = 2;
      
      private static const const_1361:uint = 14612159;
      
      private static const const_1362:uint = 15856113;
       
      
      private var _widget:PlayListEditorWidget;
      
      private var _window:IWindowContainer = null;
      
      private var var_2197:int;
      
      private var var_1650:int;
      
      private var var_2198:IContainerButtonWindow = null;
      
      private var _buttonState:int;
      
      public function MusicInventoryGridItem(param1:PlayListEditorWidget, param2:int, param3:int, param4:String, param5:ColorTransform)
      {
         super();
         this._widget = param1;
         this.var_2197 = param2;
         this.var_1650 = param3;
         this.createWindow();
         this.deselect();
         if(param4 != null && param5 != null)
         {
            this.trackName = param4;
            this.diskColor = param5;
         }
      }
      
      public function get window() : IWindow
      {
         return this._window as IWindow;
      }
      
      public function get diskId() : int
      {
         return this.var_2197;
      }
      
      public function get songId() : int
      {
         return this.var_1650;
      }
      
      public function get toPlayListButton() : IContainerButtonWindow
      {
         return this.var_2198;
      }
      
      public function get playButtonState() : int
      {
         return this._buttonState;
      }
      
      public function update(param1:int, param2:String, param3:ColorTransform) : void
      {
         if(param1 == this.var_1650)
         {
            this.trackName = param2;
            this.diskColor = param3;
         }
      }
      
      public function destroy() : void
      {
         if(this._window)
         {
            this._window.destroy();
         }
      }
      
      private function createWindow() : void
      {
         var _loc3_:* = null;
         if(this._widget == null)
         {
            return;
         }
         var _loc1_:XmlAsset = this._widget.assets.getAssetByName("playlisteditor_music_inventory_item") as XmlAsset;
         this._window = this._widget.windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer;
         if(this._window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc2_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc2_ != null)
         {
            this.var_2198 = _loc2_.getChildByName("button_to_playlist") as IContainerButtonWindow;
         }
         this.assignAssetByNameToElement("title_fader",this._window.getChildByName("title_fader_bitmap") as IBitmapWrapperWindow);
         _loc3_ = this._widget.assets.getAssetByName("icon_arrow") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            if(_loc3_.content != null)
            {
               this.buttonToPlaylistBitmap = _loc3_.content as BitmapData;
            }
         }
         this.playButtonState = const_585;
      }
      
      public function select() : void
      {
         var _loc1_:IBorderWindow = this._window.getChildByName("background") as IBorderWindow;
         if(_loc1_ != null)
         {
            _loc1_.color = const_1361;
         }
         var _loc2_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
         var _loc3_:IBorderWindow = this._window.getChildByName("selected") as IBorderWindow;
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
      }
      
      public function deselect() : void
      {
         var _loc1_:IBorderWindow = this._window.getChildByName("background") as IBorderWindow;
         if(_loc1_ != null)
         {
            _loc1_.color = const_1362;
         }
         var _loc2_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         var _loc3_:IBorderWindow = this._window.getChildByName("selected") as IBorderWindow;
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
      }
      
      public function set diskColor(param1:ColorTransform) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:BitmapDataAsset = this._widget.assets.getAssetByName("icon_cd_big") as BitmapDataAsset;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.content != null)
         {
            _loc3_ = _loc2_.content as BitmapData;
            _loc4_ = _loc3_.clone();
            if(_loc4_ != null)
            {
               _loc4_.colorTransform(_loc3_.rect,param1);
               this.diskIconBitmap = _loc4_;
            }
         }
      }
      
      public function set playButtonState(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 == const_585)
         {
            _loc2_ = this._widget.assets.getAssetByName("icon_play") as BitmapDataAsset;
         }
         else if(param1 == const_1237)
         {
            _loc2_ = this._widget.assets.getAssetByName("icon_pause") as BitmapDataAsset;
         }
         else if(param1 == const_1291)
         {
            _loc2_ = this._widget.assets.getAssetByName("icon_download") as BitmapDataAsset;
         }
         if(_loc2_ != null)
         {
            if(_loc2_.content != null)
            {
               this.buttonPlayPauseBitmap = _loc2_.content as BitmapData;
            }
         }
         this._buttonState = param1;
      }
      
      public function set trackName(param1:String) : void
      {
         var _loc2_:ITextWindow = this._window.getChildByName("song_title_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function set diskIconBitmap(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperWindow = this._window.getChildByName("disk_image") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.bitmap = param1;
         }
      }
      
      private function set buttonToPlaylistBitmap(param1:BitmapData) : void
      {
         this.assignBitmapDataToButton("button_to_playlist","image_button_to_playlist",param1);
      }
      
      private function set buttonPlayPauseBitmap(param1:BitmapData) : void
      {
         this.assignBitmapDataToButton("button_play_pause","image_button_play_pause",param1);
      }
      
      private function assignBitmapDataToButton(param1:String, param2:String, param3:BitmapData) : void
      {
         if(param3 == null)
         {
            return;
         }
         var _loc4_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_ = _loc4_.getChildByName(param1) as IWindowContainer;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow = _loc4_.getChildByName(param2) as IBitmapWrapperWindow;
         if(_loc5_ != null)
         {
            _loc5_.bitmap = param3.clone();
            _loc5_.width = param3.width;
            _loc5_.height = param3.height;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperWindow) : void
      {
         var _loc4_:* = null;
         var _loc3_:BitmapDataAsset = this._widget.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ != null)
         {
            if(param2 != null && _loc3_.content != null)
            {
               _loc4_ = _loc3_.content as BitmapData;
               param2.bitmap = _loc4_.clone();
            }
         }
      }
   }
}
