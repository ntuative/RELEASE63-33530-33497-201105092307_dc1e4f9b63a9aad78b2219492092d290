package com.sulake.habbo.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class PlayListStatusView
   {
      
      public static const const_834:String = "PLSV_ADD_SONGS";
      
      public static const const_1167:String = "PLSV_START_PLAYBACK";
      
      public static const const_605:String = "PLSV_NOW_PLAYING";
       
      
      private var _container:IWindowContainer;
      
      private var var_457:Map;
      
      private var _widget:PlayListEditorWidget;
      
      private var var_44:String;
      
      public function PlayListStatusView(param1:PlayListEditorWidget, param2:IWindowContainer)
      {
         this.var_457 = new Map();
         super();
         this._container = param2;
         this._widget = param1;
         this.createWindows();
      }
      
      public function destroy() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_457.getValues())
         {
            _loc1_.destroy();
         }
         this.var_457 = null;
      }
      
      public function selectView(param1:String) : void
      {
         this._container.removeChildAt(0);
         this._container.addChildAt(this.var_457[param1] as IWindowContainer,0);
         this.var_44 = param1;
      }
      
      public function set nowPlayingTrackName(param1:String) : void
      {
         if(this.var_44 != const_605)
         {
            return;
         }
         var _loc2_:IWindowContainer = this.var_457[this.var_44];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_track_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set nowPlayingAuthorName(param1:String) : void
      {
         if(this.var_44 != const_605)
         {
            return;
         }
         var _loc2_:IWindowContainer = this.var_457[this.var_44];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_author_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set addSongsBackgroundImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = this.var_457[const_834];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = _loc2_.getChildByName("background_image") as IBitmapWrapperWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.bitmap = param1.clone();
         _loc3_.width = param1.width;
         _loc3_.height = param1.height;
      }
      
      private function createWindows() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         _loc2_ = this._widget.assets.getAssetByName("playlisteditor_playlist_subwindow_add_songs") as XmlAsset;
         _loc1_ = this._widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc1_ != null)
         {
            this.var_457.add(const_834,_loc1_);
         }
         _loc2_ = this._widget.assets.getAssetByName("playlisteditor_playlist_subwindow_play_now") as XmlAsset;
         _loc1_ = this._widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc1_ != null)
         {
            this.var_457.add(const_1167,_loc1_);
            _loc3_ = _loc1_.getChildByName("play_now_button") as IButtonWindow;
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onPlayPauseClicked);
         }
         _loc2_ = this._widget.assets.getAssetByName("playlisteditor_playlist_subwindow_nowplaying") as XmlAsset;
         _loc1_ = this._widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc1_ != null)
         {
            this.var_457.add(const_605,_loc1_);
            _loc4_ = _loc1_.getChildByName("button_pause") as IContainerButtonWindow;
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onPlayPauseClicked);
            this.assignAssetToElement("icon_pause_large",_loc4_.getChildByName("pause_image") as IBitmapWrapperWindow);
            this.assignAssetToElement("jb_icon_disc",_loc1_.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow);
            this.assignAssetToElement("jb_icon_composer",_loc1_.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow);
         }
      }
      
      private function assignAssetToElement(param1:String, param2:IBitmapWrapperWindow) : void
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
      
      private function onPlayPauseClicked(param1:WindowMouseEvent) : void
      {
         this._widget.sendTogglePlayPauseStateMessage();
      }
   }
}
