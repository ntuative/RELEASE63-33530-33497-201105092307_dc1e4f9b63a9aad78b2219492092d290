package com.sulake.habbo.widget.playlisteditor
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
   import com.sulake.habbo.sound.IHabboSoundManager;
   import com.sulake.habbo.sound.IPlayListController;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetPlayListEditorEvent;
   import com.sulake.habbo.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetPlayListModificationMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetPlayListPlayStateMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetPlayListUserActionMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   
   public class PlayListEditorWidget extends RoomWidgetBase
   {
      
      private static const const_1497:int = 130;
      
      private static const const_1499:int = 100;
      
      private static const const_1500:int = 130;
      
      private static const const_1496:int = 100;
      
      private static const const_1501:int = 130;
      
      private static const const_1498:int = 100;
       
      
      private var _catalog:IHabboCatalog;
      
      private var var_182:IHabboConfigurationManager;
      
      private var _soundManager:IHabboSoundManager;
      
      private var var_15:MainWindowHandler;
      
      private var _furniId:int;
      
      public function PlayListEditorWidget(param1:IHabboWindowManager, param2:IHabboSoundManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:IHabboCatalog)
      {
         super(param1,param3,param4);
         this._soundManager = param2;
         this.var_182 = param5;
         this._catalog = param6;
         this.var_15 = null;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(this.var_15)
            {
               this.var_15.destroy();
               this.var_15 = null;
            }
            this._soundManager = null;
            super.dispose();
         }
      }
      
      override public function get mainWindow() : IWindow
      {
         if(this.var_15 == null)
         {
            return null;
         }
         return this.var_15.window;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         param1.addEventListener(RoomWidgetPlayListEditorEvent.const_828,this.onShowPlayListEditorEvent);
         param1.addEventListener(RoomWidgetPlayListEditorEvent.const_967,this.onHidePlayListEditorEvent);
         param1.addEventListener(RoomWidgetPlayListEditorEvent.const_948,this.onInventoryUpdatedEvent);
         param1.addEventListener(RoomWidgetPlayListEditorEvent.const_980,this.onSongDiskInventoryUpdatedEvent);
         param1.addEventListener(RoomWidgetPlayListEditorEvent.const_107,this.onPlayListUpdatedEvent);
         param1.addEventListener(RoomWidgetPlayListEditorEvent.const_144,this.onPlayListFullEvent);
         param1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.const_101,this.onNowPlayingChangedEvent);
         param1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.const_131,this.onNowPlayingChangedEvent);
         param1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.const_127,this.onNowPlayingChangedEvent);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         param1.removeEventListener(RoomWidgetPlayListEditorEvent.const_828,this.onShowPlayListEditorEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorEvent.const_967,this.onHidePlayListEditorEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorEvent.const_948,this.onInventoryUpdatedEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorEvent.const_980,this.onSongDiskInventoryUpdatedEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorEvent.const_107,this.onPlayListUpdatedEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorEvent.const_144,this.onPlayListFullEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.const_101,this.onNowPlayingChangedEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.const_131,this.onNowPlayingChangedEvent);
         param1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.const_127,this.onNowPlayingChangedEvent);
      }
      
      public function get mainWindowHandler() : MainWindowHandler
      {
         return this.var_15;
      }
      
      public function getDiskColorTransformFromSongData(param1:String) : ColorTransform
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            switch(_loc5_ % 3)
            {
               case 0:
                  _loc2_ += param1.charCodeAt(_loc5_) * 37 as int;
                  break;
               case 1:
                  _loc3_ += param1.charCodeAt(_loc5_) * 37 as int;
                  break;
               case 2:
                  _loc4_ += param1.charCodeAt(_loc5_) * 37 as int;
                  break;
            }
            _loc5_++;
         }
         _loc2_ = uint(_loc2_ % const_1499 + const_1497);
         _loc3_ = uint(_loc3_ % const_1496 + const_1500);
         _loc4_ = uint(_loc4_ % const_1498 + const_1501);
         return new ColorTransform(_loc2_ / 255,_loc3_ / 255,_loc4_ / 255);
      }
      
      public function sendAddToPlayListMessage(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:IPlayListController = this._soundManager.musicController.getRoomItemPlaylist();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = new RoomWidgetPlayListModificationMessage(RoomWidgetPlayListModificationMessage.const_950,_loc3_,param1);
            if(messageListener != null)
            {
               messageListener.processWidgetMessage(_loc4_);
            }
         }
      }
      
      public function sendRemoveFromPlayListMessage(param1:int) : void
      {
         var _loc2_:RoomWidgetPlayListModificationMessage = new RoomWidgetPlayListModificationMessage(RoomWidgetPlayListModificationMessage.const_849,param1);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      public function sendTogglePlayPauseStateMessage() : void
      {
         var _loc1_:int = 0;
         if(this.var_15 != null && this.var_15.playListEditorView != null)
         {
            _loc1_ = this.var_15.playListEditorView.selectedItemIndex != -1 ? int(this.var_15.playListEditorView.selectedItemIndex) : 0;
         }
         var _loc2_:RoomWidgetPlayListPlayStateMessage = new RoomWidgetPlayListPlayStateMessage(RoomWidgetPlayListPlayStateMessage.const_709,this._furniId,_loc1_);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      public function playUserSong(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = this._soundManager.musicController.getSongIdPlayingAtPriority(HabboMusicPrioritiesEnum.const_129);
         if(_loc2_ != -1)
         {
            _loc3_ = this._soundManager.musicController.getSongInfo(_loc2_);
            if(_loc3_.soundObject != null)
            {
               _loc3_.soundObject.fadeOutSeconds = 0;
            }
         }
         this._soundManager.musicController.playSong(param1,HabboMusicPrioritiesEnum.const_418,0,0,0,0);
      }
      
      public function stopUserSong() : void
      {
         this._soundManager.musicController.stop(HabboMusicPrioritiesEnum.const_418);
      }
      
      public function getImageGalleryAssetBitmap(param1:String) : BitmapData
      {
         var _loc3_:* = null;
         var _loc2_:BitmapDataAsset = this.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         _loc3_ = _loc2_.content as BitmapData;
         return _loc3_.clone();
      }
      
      public function retrieveWidgetImage(param1:String) : void
      {
         var _loc2_:String = this.var_182.getKey("image.library.playlist.url");
         var _loc3_:* = _loc2_ + param1 + ".gif";
         Logger.log("[PlayListEditorWidget]  : " + _loc3_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:AssetLoaderStruct = this.assets.loadAssetFromFile(param1,_loc4_,"image/gif");
         _loc5_.addEventListener(AssetLoaderEvent.const_29,this.onWidgetImageReady);
      }
      
      public function openSongDiskShopCataloguePage() : void
      {
         var _loc1_:RoomWidgetPlayListUserActionMessage = new RoomWidgetPlayListUserActionMessage(RoomWidgetPlayListUserActionMessage.const_966);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
         this._catalog.openCatalogPage(CatalogPageName.const_1872,true);
      }
      
      public function alertPlayListFull() : void
      {
         this.windowManager.alert("${playlist.editor.alert.playlist.full.title}","${playlist.editor.alert.playlist.full}",0,this.alertHandler);
      }
      
      private function alertHandler(param1:IAlertDialog, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function onShowPlayListEditorEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         var _loc2_:* = null;
         this._furniId = param1.furniId;
         if(!this.var_15)
         {
            this.var_15 = new MainWindowHandler(this,this._soundManager.musicController);
            this.var_15.window.visible = false;
         }
         if(!this.var_15.window.visible)
         {
            this.var_15.show();
            this._soundManager.musicController.requestUserSongDisks();
            _loc2_ = this._soundManager.musicController.getRoomItemPlaylist();
            if(_loc2_ != null)
            {
               _loc2_.requestPlayList();
            }
         }
      }
      
      private function onHidePlayListEditorEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(this.var_15 != null)
         {
            if(this.var_15.window.visible)
            {
               this.var_15.hide();
            }
         }
      }
      
      private function onInventoryUpdatedEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(!this.var_15)
         {
            return;
         }
         if(this.var_15.window.visible)
         {
            this._soundManager.musicController.requestUserSongDisks();
         }
      }
      
      private function onWidgetImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:* = null;
         if(param1.type == AssetLoaderEvent.const_29)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               if(this.var_15 != null)
               {
                  this.var_15.refreshLoadableAsset(_loc2_.assetName);
               }
            }
         }
      }
      
      private function onSongDiskInventoryUpdatedEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(this.var_15)
         {
            this.var_15.onSongDiskInventoryReceived();
         }
      }
      
      private function onPlayListUpdatedEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(this.var_15)
         {
            this.var_15.onPlayListUpdated();
         }
      }
      
      private function onPlayListFullEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         this.alertPlayListFull();
      }
      
      private function onNowPlayingChangedEvent(param1:RoomWidgetPlayListEditorNowPlayingEvent) : void
      {
         if(this.var_15)
         {
            this.var_15.onNowPlayingChanged(param1);
         }
      }
   }
}
