package
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ICore;
   import com.sulake.core.runtime.events.LibraryProgressEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   
   public class HabboMain extends Sprite
   {
      
      private static const const_986:Number = 0.71;
       
      
      private var var_22:ICore;
      
      private var var_1608:Boolean = false;
      
      private var var_1:DisplayObjectContainer;
      
      private var var_1337:HabboTracking;
      
      public function HabboMain(param1:DisplayObjectContainer)
      {
         super();
         this.var_1 = param1;
         this.var_1.addEventListener(Event.COMPLETE,this.onCompleteEvent);
         this.var_1.addEventListener(ProgressEvent.PROGRESS,this.onProgressEvent);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         Logger.log("Core version: undefined");
      }
      
      private function dispose() : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(this.var_1)
         {
            this.var_1.removeEventListener(Event.COMPLETE,this.onCompleteEvent);
            this.var_1.removeEventListener(ProgressEvent.PROGRESS,this.onProgressEvent);
            this.var_1 = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initializeCore() : void
      {
         try
         {
            this.var_22.initialize();
            if(false)
            {
               ExternalInterface.addCallback("unloading",this.unloading);
            }
         }
         catch(error:Error)
         {
            Habbo.trackLoginStep(Habbo.const_21);
            Core.crash("Failed to initialize the core: " + error.message,Core.const_1143,error);
         }
      }
      
      public function unloading() : void
      {
         if(this.var_22 && !this.var_22.disposed)
         {
            this.var_22.events.dispatchEvent(new Event(Event.UNLOAD));
         }
      }
      
      protected function onAddedToStage(param1:Event = null) : void
      {
         var event:Event = param1;
         try
         {
            this.prepareCore();
         }
         catch(error:Error)
         {
            Habbo.trackLoginStep(Habbo.const_21);
            Habbo.reportCrash("Failed to prepare the core: " + error.message,Core.const_1143,error);
            Core.dispose();
         }
      }
      
      private function prepareCore() : void
      {
         Habbo.trackLoginStep(Habbo.const_23);
         this.var_22 = Core.instantiate(stage,0);
         this.var_22.events.addEventListener(Component.COMPONENT_EVENT_ERROR,this.onCoreError);
         this.var_22.prepareComponent(CoreCommunicationFrameworkLib);
         this.var_22.prepareComponent(HabboRoomObjectLogicLib);
         this.var_22.prepareComponent(HabboRoomObjectVisualizationLib);
         this.var_22.prepareComponent(RoomManagerLib);
         this.var_22.prepareComponent(RoomSpriteRendererLib);
         this.var_22.prepareComponent(HabboRoomSessionManagerLib);
         this.var_22.prepareComponent(HabboAvatarRenderLib);
         this.var_22.prepareComponent(HabboRoomWidgetLib);
         this.var_22.prepareComponent(HabboSessionDataManagerLib);
         this.var_22.prepareComponent(HabboTrackingLib);
         this.var_22.prepareComponent(HabboConfigurationCom);
         this.var_22.prepareComponent(HabboLocalizationCom);
         this.var_22.prepareComponent(HabboWindowManagerCom);
         this.var_22.prepareComponent(HabboCommunicationCom);
         this.var_22.prepareComponent(HabboCommunicationDemoCom);
         this.var_22.prepareComponent(HabboNavigatorCom);
         this.var_22.prepareComponent(HabboFriendListCom);
         this.var_22.prepareComponent(HabboMessengerCom);
         this.var_22.prepareComponent(HabboInventoryCom);
         this.var_22.prepareComponent(HabboToolbarCom);
         this.var_22.prepareComponent(HabboCatalogCom);
         this.var_22.prepareComponent(HabboRoomEngineCom);
         this.var_22.prepareComponent(HabboRoomUICom);
         this.var_22.prepareComponent(HabboAvatarEditorCom);
         this.var_22.prepareComponent(HabboNotificationsCom);
         this.var_22.prepareComponent(HabboHelpCom);
         this.var_22.prepareComponent(HabboAdManagerCom);
         this.var_22.prepareComponent(HabboModerationCom);
         this.var_22.prepareComponent(HabboUserDefinedRoomEventsCom);
         this.var_22.prepareComponent(HabboSoundManagerFlash10Com);
         this.var_22.prepareComponent(HabboQuestEngineCom);
         this.var_22.prepareComponent(HabboFriendBarCom);
         this.var_1337 = HabboTracking.getInstance();
         var _loc1_:AssetLoaderStruct = this.var_22.assets.loadAssetFromFile("config.xml",new URLRequest("config_habbo.xml"));
         if(_loc1_.assetLoader.ready)
         {
            this.setupCoreConfigFromLoader(_loc1_);
         }
         else
         {
            _loc1_.addEventListener(AssetLoaderEvent.const_29,this.configLoadedHandler);
            _loc1_.addEventListener(AssetLoaderEvent.const_49,this.configLoadedHandler);
         }
      }
      
      private function configLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc2_:* = null;
         _loc2_ = param1.target as AssetLoaderStruct;
         _loc2_.removeEventListener(AssetLoaderEvent.const_29,this.configLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_49,this.configLoadedHandler);
         if(param1.type == AssetLoaderEvent.const_29)
         {
            this.setupCoreConfigFromLoader(_loc2_);
         }
         else
         {
            Habbo.reportCrash("Failed to download external configuration document " + _loc2_.assetLoader.url + "!",Core.const_319,null);
         }
      }
      
      private function setupCoreConfigFromLoader(param1:AssetLoaderStruct) : void
      {
         var _loc2_:XmlAsset = this.var_22.assets.getAssetByName(param1.assetName) as XmlAsset;
         if(!_loc2_ || !_loc2_.content)
         {
            Habbo.reportCrash("Download external configuration document is null!",Core.const_319,null);
         }
         if(this.var_22)
         {
            this.var_22.readConfigDocument(XML(_loc2_.content),this.var_1);
         }
         else
         {
            Habbo.reportCrash("Core vanished while downloading config document!",Core.const_319,null);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:* = null;
         if(this.var_1)
         {
            _loc2_ = this.var_1.getChildByName("background") as Sprite;
            if(_loc2_)
            {
               _loc2_.alpha -= 0.01;
               if(_loc2_.alpha <= 0)
               {
               }
            }
            if(this.var_1608)
            {
               if(this.var_1.alpha <= 0)
               {
                  this.dispose();
                  this.var_1608 = false;
               }
               else
               {
                  this.var_1.alpha -= 0.1;
               }
            }
         }
      }
      
      private function onCompleteEvent(param1:Event) : void
      {
         this.updateLoadingBar(this.var_1,1);
         this.initializeCore();
         this.var_1608 = true;
      }
      
      private function onProgressEvent(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(this.var_1)
         {
            _loc2_ = param1.bytesLoaded / param1.bytesTotal;
            this.updateLoadingBar(this.var_1,_loc2_);
            _loc3_ = this.var_1.getChildByName("background") as Sprite;
            if(_loc3_)
            {
               _loc3_.alpha = Math.min(1 - _loc2_,_loc3_.alpha);
            }
            if(param1 is LibraryProgressEvent)
            {
               _loc4_ = param1 as LibraryProgressEvent;
               if(_loc4_.fileName == "hh_human_fx.swf" || _loc4_.fileName == "hh_human_body.swf")
               {
                  if(this.var_1337 && !this.var_1337.disposed)
                  {
                     this.var_1337.track("libraryLoaded",_loc4_.fileName,_loc4_.elapsedTime);
                  }
               }
            }
         }
      }
      
      private function updateLoadingBar(param1:DisplayObjectContainer, param2:Number) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:Sprite = param1.getChildByName(Habbo.const_2) as Sprite;
         var _loc8_:Sprite = _loc7_.getChildByName(Habbo.const_8) as Sprite;
         var _loc11_:int = this.var_22.getNumberOfFilesPending() + this.var_22.getNumberOfFilesLoaded();
         var _loc12_:Number = 1 - const_986 + this.var_22.getNumberOfFilesLoaded() / _loc11_ * const_986;
         _loc8_.x = 1 + 1;
         _loc8_.y = 1 + 1;
         _loc8_.graphics.clear();
         _loc9_ = 16;
         _loc10_ = 196 * _loc12_;
         _loc8_.graphics.beginFill(12241619);
         _loc8_.graphics.drawRect(0,0,_loc10_,_loc9_ / 2);
         _loc8_.graphics.endFill();
         _loc8_.graphics.beginFill(9216429);
         _loc8_.graphics.drawRect(0,_loc9_ / 2,_loc10_,_loc9_ / 2 + 1);
         _loc8_.graphics.endFill();
      }
      
      public function onCoreError(param1:Event) : void
      {
         Habbo.trackLoginStep(Habbo.const_21);
      }
   }
}
