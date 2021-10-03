package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementBonusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementShareIdMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusCannotEnterMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageParser;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageParser;
   import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedParser;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageParser;
   import com.sulake.habbo.communication.messages.parser.moderation.ModMessageParser;
   import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;
   import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationParser;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;
   import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationParser;
   import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationParser;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedParser;
   import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusCannotEnterMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.enum.FurniCategory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import iid.IIDHabboWindowManager;
   
   public class HabboNotifications extends Component implements IHabboNotifications, IUpdateReceiver, IGetImageListener
   {
      
      private static const const_1548:String = "pixelbalance";
      
      private static const const_1542:String = "badges";
      
      private static const const_1545:String = "selectbadge";
      
      private static const const_1549:String = "inventory";
      
      private static const const_1547:String = "selectfurni";
      
      private static const UILINK_CREDITS:String = "credits";
      
      private static const const_1546:String = "friendlist";
      
      private static const const_1543:String = "pet_inventory";
      
      private static const const_1544:String = "go_to_room";
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_370:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _inventory:IHabboInventory;
      
      private var _friendList:IHabboFriendList;
      
      private var var_831:IHabboToolbar;
      
      private var var_523:IAvatarRenderManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _config:IHabboConfigurationManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_1276:Array;
      
      private var var_1045:Map;
      
      private var var_391:HabboNotificationViewManager;
      
      private var var_234:HabboAlertDialogManager;
      
      private var var_832:ParkBusDialogManager;
      
      private var var_2806:Boolean;
      
      private var var_1046:ClubGiftNotification;
      
      private var var_1047:ClubEndingNotification;
      
      private var var_1044:ClubPromoNotification;
      
      private var var_1577:Dictionary;
      
      private var var_2008:Boolean;
      
      public function HabboNotifications(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         super(param1,param2,param3);
         this._assetLibrary = param3;
         this.var_1276 = new Array();
         this.var_1045 = new Map();
         this.var_2008 = false;
         this.var_1577 = new Dictionary();
         var _loc4_:IAsset = this._assetLibrary.getAssetByName("habbo_notifications_config_xml");
         var _loc5_:XmlAsset = XmlAsset(_loc4_);
         if(_loc5_ != null)
         {
            XMLVariableParser.parseVariableList(XML(_loc5_.content).children(),this.var_1045);
         }
         var _loc6_:Map = this.var_1045["styles"];
         if(_loc6_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc8_ = _loc6_.getWithIndex(_loc7_);
               if(_loc8_["icon"] != null)
               {
                  _loc9_ = this._assetLibrary.getAssetByName(_loc8_["icon"]) as BitmapDataAsset;
                  _loc10_ = _loc9_.content as BitmapData;
                  _loc8_["icon"] = _loc10_;
               }
               _loc7_++;
            }
         }
         queueInterface(new IIDHabboInventory(),this.onInventoryReady);
         queueInterface(new IIDHabboFriendList(),this.onFriendListReady);
         queueInterface(new IIDSessionDataManager(),this.onSessionDataManagerReady);
         queueInterface(new IIDAvatarRenderManager(),this.onAvatarRenderManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),this.onCommunicationComponentInit);
         queueInterface(new IIDRoomEngine(),this.onRoomEngineReady);
         queueInterface(new IIDHabboConfigurationManager(),this.onConfigurationManagerReady);
         queueInterface(new IIDHabboCatalog(),this.onCatalogReady);
      }
      
      override public function dispose() : void
      {
         if(this.var_391 != null)
         {
            this.var_391.dispose();
            this.var_391 = null;
         }
         if(this.var_234 != null)
         {
            this.var_234.dispose();
            this.var_234 = null;
         }
         if(this.var_832 != null)
         {
            this.var_832.dispose();
            this.var_832 = null;
         }
         if(this.var_1046 != null)
         {
            this.var_1046.dispose();
            this.var_1046 = null;
         }
         if(this.var_1047)
         {
            this.var_1047.dispose();
            this.var_1047 = null;
         }
         if(this.var_1044)
         {
            this.var_1044.dispose();
            this.var_1044 = null;
         }
         if(this.var_523)
         {
            this.var_523.release(new IIDAvatarRenderManager());
            this.var_523 = null;
         }
         if(this._catalog)
         {
            this._catalog.release(new IIDHabboCatalog());
            this._catalog = null;
         }
         if(this._communication)
         {
            this._communication.release(new IIDHabboCommunicationManager());
            this._communication = null;
         }
         if(this._config)
         {
            this._config.release(new IIDHabboConfigurationManager());
            this._config = null;
         }
         if(this._friendList)
         {
            this._friendList.release(new IIDHabboFriendList());
            this._friendList = null;
         }
         if(this._inventory)
         {
            this._inventory.release(new IIDHabboInventory());
            this._inventory = null;
         }
         if(this._localization)
         {
            this._localization.release(new IIDHabboLocalizationManager());
            this._localization = null;
         }
         if(this._roomEngine)
         {
            this._roomEngine.release(new IIDRoomEngine());
            this._roomEngine = null;
         }
         if(this.var_370)
         {
            this.var_370.release(new IIDSessionDataManager());
            this.var_370 = null;
         }
         if(this.var_831)
         {
            this.var_831.release(new IIDHabboToolbar());
            this.var_831 = null;
         }
         if(this._windowManager)
         {
            this._windowManager.release(new IIDHabboWindowManager());
            this._windowManager = null;
         }
         super.dispose();
      }
      
      private function addItem(param1:String, param2:String, param3:BitmapData, param4:String = null) : int
      {
         if(this.var_2008)
         {
            return 0;
         }
         var _loc5_:Map = this.var_1045["styles"];
         if(_loc5_ == null)
         {
            return 0;
         }
         var _loc6_:Map = _loc5_[param2];
         if(_loc6_ == null)
         {
            return 0;
         }
         var _loc7_:HabboNotificationItemStyle = new HabboNotificationItemStyle(_loc6_,param3,true,param4);
         var _loc8_:HabboNotificationItem = new HabboNotificationItem(param1,_loc7_,this);
         this.var_1276.push(_loc8_);
         return this.var_1276.length;
      }
      
      private function getNextItemFromQueue() : HabboNotificationItem
      {
         var _loc1_:Array = this.var_1276.splice(0,1);
         return _loc1_[0] as HabboNotificationItem;
      }
      
      private function onCommunicationComponentInit(param1:IID = null, param2:IUnknown = null) : void
      {
         this._communication = IHabboCommunicationManager(param2);
         queueInterface(new IIDHabboWindowManager(),this.onWindowManagerReady);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         this._windowManager = IHabboWindowManager(param2);
         queueInterface(new IIDHabboLocalizationManager(),this.onLocalizationReady);
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this._localization = param2 as IHabboLocalizationManager;
         this.var_234 = new HabboAlertDialogManager(this._windowManager,this._localization);
         queueInterface(new IIDHabboToolbar(),this.onToolbarReady);
         if(this._communication)
         {
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOk));
            this._communication.addHabboConnectionMessageEvent(new MOTDNotificationEvent(this.onMOTD));
         }
      }
      
      private function onInventoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this._inventory = param2 as IHabboInventory;
      }
      
      private function onFriendListReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this._friendList = param2 as IHabboFriendList;
      }
      
      private function onAvatarRenderManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_523 = param2 as IAvatarRenderManager;
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         this.var_831 = IHabboToolbar(param2);
         this.var_831.events.addEventListener(HabboToolbarEvent.const_71,this.onHabboToolbarEvent);
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         this.var_370 = param2 as ISessionDataManager;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         this._roomEngine = param2 as IRoomEngine;
      }
      
      private function onConfigurationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         this._config = param2 as IHabboConfigurationManager;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         this._catalog = param2 as IHabboCatalog;
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == HabboToolbarEvent.const_71)
         {
            Logger.log("Notifications: starting to respond to notifications");
            this.var_391 = new HabboNotificationViewManager(this._assetLibrary,this._windowManager,this.var_1045["styles"],this.var_1045["view"],this.var_831);
            this._communication.addHabboConnectionMessageEvent(new HabboBroadcastMessageEvent(this.onBroadcastMessageEvent));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(this.onAchievementNotication));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementShareIdMessageEvent(this.onAchievementShareId));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementBonusMessageEvent(this.onAchievementBonus));
            this._communication.addHabboConnectionMessageEvent(new RespectNotificationMessageEvent(this.onRespectNotification));
            this._communication.addHabboConnectionMessageEvent(new PurchaseOKMessageEvent(this.onPurchaseOK));
            this._communication.addHabboConnectionMessageEvent(new RecyclerFinishedMessageEvent(this.onRecyclerFinished));
            this._communication.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(this.onSubscriptionInfo));
            this._communication.addHabboConnectionMessageEvent(new InfoFeedEnableMessageEvent(this.onInfoFeedEnable));
            this._communication.addHabboConnectionMessageEvent(new ModMessageEvent(this.onModMessageEvent));
            this._communication.addHabboConnectionMessageEvent(new UserBannedMessageEvent(this.onUserBannedMessageEvent));
            this._communication.addHabboConnectionMessageEvent(new InfoHotelClosingMessageEvent(this.onHotelClosing));
            this._communication.addHabboConnectionMessageEvent(new InfoHotelClosedMessageEvent(this.onHotelClosed));
            this._communication.addHabboConnectionMessageEvent(new LoginFailedHotelClosedMessageEvent(this.onLoginFailedHotelClosed));
            this._communication.addHabboConnectionMessageEvent(new ParkBusCannotEnterMessageEvent(this.onParkBusMessageEvent));
            this._communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._communication.addHabboConnectionMessageEvent(new PetLevelNotificationEvent(this.onPetLevelNotification));
            this._communication.addHabboConnectionMessageEvent(new PetReceivedMessageEvent(this.onPetReceived));
            this._communication.addHabboConnectionMessageEvent(new PetRespectFailedEvent(this.onPetRespectFailed));
            this._communication.addHabboConnectionMessageEvent(new ClubGiftNotificationEvent(this.onClubGiftNotification));
            this._communication.addHabboConnectionMessageEvent(new ClubGiftSelectedEvent(this.onClubGiftSelected));
            this._communication.addHabboConnectionMessageEvent(new RoomMessageNotificationMessageEvent(this.onRoomMessagesNotification));
            registerUpdateReceiver(this.var_391,1);
            registerUpdateReceiver(this,2);
            this.var_370.events.addEventListener(BadgeImageReadyEvent.const_115,this.onBadgeImage);
            this.var_831.events.addEventListener(HabboToolbarEvent.const_1628,this.onToolbarRepositionEvent);
         }
      }
      
      public function setQuestTrackerVisible(param1:Boolean) : void
      {
         if(this.var_391)
         {
            this.var_391.topMarginIncrease = !!param1 ? 135 : 0;
         }
      }
      
      function onAchievementNotication(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         this.var_1577[_loc2_.badgeID] = new AchievementNotification(_loc2_.badgeID,_loc2_.achievementID,_loc2_.level,_loc2_.points,_loc2_.levelRewardPoints,_loc2_.levelRewardPointType,_loc2_.bonusPoints,assets,this._windowManager,this._localization,this._config,this._communication,this.var_370);
      }
      
      function onAchievementShareId(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementShareIdMessageEvent = param1 as HabboAchievementShareIdMessageEvent;
         var _loc3_:AchievementNotification = this.var_1577[_loc2_.badgeID] as AchievementNotification;
         delete this.var_1577[_loc2_.badgeID];
         if(_loc3_)
         {
            _loc3_.requestPostDialog(_loc2_.shareID);
            _loc3_.dispose();
         }
      }
      
      function onAchievementBonus(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementBonusMessageEvent = param1 as HabboAchievementBonusMessageEvent;
         new AchievementNotificationBonus(_loc2_.bonusPoints,_loc2_.realName,assets,this._windowManager,this._localization);
      }
      
      function onAuthenticationOk(param1:IMessageEvent) : void
      {
         this._communication.getHabboMainConnection(null).send(new GetMOTDMessageComposer());
      }
      
      function onMOTD(param1:IMessageEvent) : void
      {
         var _loc2_:MOTDNotificationEvent = param1 as MOTDNotificationEvent;
         var _loc3_:MOTDNotificationParser = _loc2_.getParser() as MOTDNotificationParser;
         if(_loc3_.messages && _loc3_.messages.length > 0)
         {
            new MOTDNotification(_loc3_.messages,this._assetLibrary,this._windowManager);
         }
      }
      
      function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:RespectNotificationMessageEvent = param1 as RespectNotificationMessageEvent;
         if(this.var_370.userId == _loc2_.userId)
         {
            this._localization.registerParameter("notifications.text.respect.2","count",String(_loc2_.respectTotal));
            _loc3_ = this._localization.getLocalization("notifications.text.respect.1");
            _loc4_ = this._localization.getLocalization("notifications.text.respect.2");
            if(_loc3_)
            {
               this.addItem(_loc3_.value,NotificationType.const_1142,null);
            }
            if(_loc4_)
            {
               this.addItem(_loc4_.value,NotificationType.const_1142,null);
            }
         }
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         this._localization.registerParameter("soundmachine.notification.playing","songname",param1);
         this._localization.registerParameter("soundmachine.notification.playing","songauthor",param2);
         var _loc3_:ILocalization = this._localization.getLocalization("soundmachine.notification.playing");
         if(_loc3_)
         {
            this.addItem(_loc3_.value,NotificationType.const_1689,null);
         }
      }
      
      public function showGenericNotification(param1:String) : void
      {
         this.addItem(param1,NotificationType.const_866,null);
      }
      
      public function addOnlineNotification(param1:String, param2:String, param3:String = "") : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc7_:IAvatarImage = this.var_523.createAvatarImage(param2,AvatarScaleType.const_56);
         if(_loc7_ != null)
         {
            _loc7_.setDirection(AvatarSetType.const_51,3);
            _loc4_ = _loc7_.getCroppedImage(AvatarSetType.const_51);
            _loc7_.dispose();
         }
         if(param3 == "")
         {
            this._localization.registerParameter("notifications.text.friend.online","user_name",param1);
            _loc5_ = this._localization.getLocalization("notifications.text.friend.online");
            _loc6_ = "null";
         }
         else
         {
            this._localization.registerParameter("notifications.text.friend.online.realname","user_name",param1);
            _loc5_ = this._localization.getLocalization("notifications.text.friend.online.realname");
            this._localization.registerParameter("notifications.text.friend.online.realname","real_name",param3);
            _loc5_ = this._localization.getLocalization("notifications.text.friend.online.realname");
            _loc6_ = "null";
            _loc9_ = assets.getAssetByName("if_icon_friend_bg_blue_png") as BitmapDataAsset;
            if(_loc9_ != null && _loc4_ != null)
            {
               _loc8_ = (_loc9_.content as BitmapData).clone();
               _loc8_.copyPixels(_loc4_,_loc4_.rect,new Point((_loc8_.width - _loc4_.width) / 2,(_loc8_.height - _loc4_.height) / 2),null,null,true);
               _loc4_.dispose();
               _loc4_ = _loc8_;
            }
         }
         if(_loc5_)
         {
            this.addItem(_loc5_.value,_loc6_,_loc4_);
         }
      }
      
      public function addOfflineNotification(param1:String, param2:String = "") : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2 == "")
         {
            this._localization.registerParameter("notifications.text.friend.offline","user_name",param1);
            _loc4_ = this._localization.getLocalization("notifications.text.friend.offline");
            _loc3_ = "null";
         }
         else
         {
            this._localization.registerParameter("notifications.text.friend.offline.realname","user_name",param1);
            this._localization.registerParameter("notifications.text.friend.offline.realname","real_name",param2);
            _loc4_ = this._localization.getLocalization("notifications.text.friend.offline.realname");
            _loc3_ = "null";
         }
         if(_loc4_)
         {
            this.addItem(_loc4_.value,_loc3_,null);
         }
      }
      
      private function onRoomMessagesNotification(param1:RoomMessageNotificationMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:RoomMessageNotificationMessageParser = param1.getParser();
         var _loc4_:String = "null";
         this._localization.registerParameter("notifications.text.room.messages.posted","room_name",_loc2_.roomName);
         this._localization.registerParameter("notifications.text.room.messages.posted","messages_count",_loc2_.messageCount.toString());
         _loc3_ = this._localization.getLocalization("notifications.text.room.messages.posted");
         var _loc5_:BitmapDataAsset = assets.getAssetByName("if_icon_temp_png") as BitmapDataAsset;
         var _loc6_:BitmapData = _loc5_.content as BitmapData;
         if(_loc3_)
         {
            this.addItem(_loc3_.value,_loc4_,_loc6_.clone());
         }
      }
      
      private function onPurchaseOK(param1:IMessageEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc2_:PurchaseOKMessageEvent = param1 as PurchaseOKMessageEvent;
         var _loc3_:PurchaseOKMessageParser = _loc2_.getParser();
         var _loc4_:CatalogPageMessageOfferData = _loc3_.offer;
         var _loc5_:* = null;
         if(_loc4_ == null)
         {
            return;
         }
         for each(_loc6_ in _loc4_.products)
         {
            if(_loc6_)
            {
               if(_loc6_.productType == CatalogPageMessageProductData.const_78)
               {
                  _loc7_ = this.var_370.getFloorItemData(_loc6_.furniClassId);
               }
               else if(_loc6_.productType == CatalogPageMessageProductData.const_66)
               {
                  _loc7_ = this.var_370.getWallItemData(_loc6_.furniClassId);
               }
               _loc5_ = this.getProductImage(_loc6_.productType,_loc6_.furniClassId,_loc6_.extraParam);
               if(_loc7_ && _loc7_.title != "")
               {
                  this._localization.registerParameter("notifications.text.purchase.ok","productName",_loc7_.title);
               }
               else
               {
                  _loc9_ = this.var_370.getProductData(_loc4_.localizationId);
                  if(_loc9_)
                  {
                     this._localization.registerParameter("notifications.text.purchase.ok","productName",_loc9_.name);
                  }
               }
               _loc8_ = this._localization.getLocalization("notifications.text.purchase.ok");
               if(_loc8_)
               {
                  this.addItem(_loc8_.value,NotificationType.const_1870,_loc5_);
               }
            }
         }
         Logger.log("[HabboNotifications] purchase ok");
      }
      
      private function getProductImage(param1:String, param2:int, param3:String) : BitmapData
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         switch(param1)
         {
            case CatalogPageMessageProductData.const_78:
               _loc5_ = this._roomEngine.getFurnitureIcon(param2,this);
               break;
            case CatalogPageMessageProductData.const_66:
               _loc7_ = this.tempCategoryMapping("I",param2);
               if(_loc7_ == 1)
               {
                  _loc5_ = this._roomEngine.getWallItemIcon(param2,this,param3);
               }
               else
               {
                  switch(_loc7_)
                  {
                     case FurniCategory.const_315:
                        _loc4_ = (this._inventory as Component).assets.getAssetByName("icon_wallpaper_png") as BitmapDataAsset;
                        if(_loc4_ != null)
                        {
                           _loc6_ = (_loc4_.content as BitmapData).clone();
                        }
                        break;
                     case FurniCategory.const_307:
                        _loc4_ = (this._inventory as Component).assets.getAssetByName("icon_landscape_png") as BitmapDataAsset;
                        if(_loc4_ != null)
                        {
                           _loc6_ = (_loc4_.content as BitmapData).clone();
                        }
                        break;
                     case FurniCategory.const_323:
                        _loc4_ = (this._inventory as Component).assets.getAssetByName("icon_floor_png") as BitmapDataAsset;
                        if(_loc4_ != null)
                        {
                           _loc6_ = (_loc4_.content as BitmapData).clone();
                        }
                  }
                  _loc5_ = null;
               }
               break;
            case CatalogPageMessageProductData.const_205:
               _loc4_ = (this._inventory as Component).assets.getAssetByName("fx_icon_" + param2 + "_png") as BitmapDataAsset;
               if(_loc4_ != null)
               {
                  _loc6_ = (_loc4_.content as BitmapData).clone();
               }
               break;
            default:
               Logger.log("[HabboNotifications] Can not yet handle this type of product: ");
         }
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.data;
         }
         return _loc6_;
      }
      
      private function onRecyclerFinished(param1:IMessageEvent) : void
      {
         var _loc2_:RecyclerFinishedMessageParser = (param1 as RecyclerFinishedMessageEvent).getParser();
         if(_loc2_ == null || _loc2_.recyclerFinishedStatus != RecyclerFinishedMessageEvent.const_1234)
         {
            return;
         }
         var _loc3_:ILocalization = this._localization.getLocalization("notifications.text.recycle.ok");
         if(_loc3_)
         {
            this.addItem(_loc3_.value,NotificationType.const_1783,null);
         }
         Logger.log("[HabboNotifications] recycle ok");
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         Logger.log("[HabboNotifications] subscription update");
         var _loc2_:ScrSendUserInfoMessageParser = (param1 as ScrSendUserInfoEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.responseType == ScrSendUserInfoMessageParser.const_1704)
         {
            _loc3_ = Math.max(0,_loc2_.daysToPeriodEnd);
            _loc4_ = Math.max(0,_loc2_.periodsSubscribedAhead);
            if(_loc2_.isVIP)
            {
               _loc5_ = "notifications.text.vipdays";
               _loc6_ = "null";
            }
            else
            {
               _loc5_ = "notifications.text.clubdays";
               _loc6_ = "null";
            }
            if(_loc4_ > 0)
            {
               _loc5_ += ".long";
            }
            this._localization.registerParameter(_loc5_,"days",String(_loc3_));
            this._localization.registerParameter(_loc5_,"months",String(_loc4_));
            _loc7_ = this._localization.getLocalization(_loc5_);
            if(_loc7_)
            {
               this.addItem(_loc7_.value,_loc6_,null);
            }
         }
         else
         {
            _loc8_ = parseInt(this._config.getKey("subscription.reminder.when.days.left","5"));
            if(_loc8_ > 0 && _loc2_.daysToPeriodEnd > 0 && _loc2_.daysToPeriodEnd <= _loc8_ && _loc2_.periodsSubscribedAhead == 0)
            {
               if(this.var_1047)
               {
                  this.var_1047.dispose();
               }
               this.var_1047 = new ClubEndingNotification(_loc2_.daysToPeriodEnd,_loc2_.isVIP,assets,this._windowManager,this._catalog,this._localization);
            }
            if(_loc2_.isShowBasicPromo)
            {
               if(this.var_1044)
               {
                  this.var_1044.dispose();
               }
               this.var_1044 = new ClubPromoNotification(_loc2_.basicNormalPrice,_loc2_.basicPromoPrice,assets,this._windowManager,this._catalog,this._localization);
            }
         }
      }
      
      private function onInfoFeedEnable(param1:IMessageEvent) : void
      {
         var _loc2_:InfoFeedEnableMessageEvent = param1 as InfoFeedEnableMessageEvent;
         if(_loc2_ != null)
         {
            this.var_2008 = !_loc2_.enabled;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = null;
         if(this.var_391.isSpaceAvailable() && this.var_1276.length > 0)
         {
            _loc2_ = this.getNextItemFromQueue();
            if(!this.var_391.showItem(_loc2_))
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function onExecuteLink(param1:String) : void
      {
         switch(param1)
         {
            case const_1548:
               break;
            case const_1542:
               if(this._inventory != null)
               {
                  this._inventory.toggleInventoryPage(InventoryCategory.const_356);
               }
               break;
            case const_1545:
               break;
            case const_1549:
               if(this._inventory != null && this._inventory.hasRoomSession)
               {
                  this._inventory.toggleInventoryPage(InventoryCategory.const_82);
               }
               break;
            case const_1543:
               if(this._inventory != null && this._inventory.hasRoomSession)
               {
                  this._inventory.toggleInventoryPage(InventoryCategory.const_163);
               }
               break;
            case const_1547:
               break;
            case UILINK_CREDITS:
               break;
            case const_1546:
               if(this._friendList != null)
               {
                  this._friendList.openFriendList();
               }
               break;
            case const_1544:
         }
      }
      
      private function onBadgeImage(param1:BadgeImageReadyEvent) : void
      {
         if(param1 != null && this.var_391 != null)
         {
            this.var_391.replaceIcon(param1);
         }
      }
      
      private function onToolbarRepositionEvent(param1:HabboToolbarEvent) : void
      {
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      private function tempCategoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return FurniCategory.const_315;
            }
            if(param2 == 3002)
            {
               return FurniCategory.const_323;
            }
            if(param2 == 4057)
            {
               return FurniCategory.const_307;
            }
            return 1;
         }
         return 1;
      }
      
      private function onModMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:ModMessageParser = (param1 as ModMessageEvent).getParser();
         if(_loc2_ == null || this.var_234 == null)
         {
            return;
         }
         this.var_234.handleModMessage(_loc2_.message,_loc2_.url);
      }
      
      private function onUserBannedMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:UserBannedMessageParser = (param1 as UserBannedMessageEvent).getParser();
         if(_loc2_ == null || this.var_234 == null)
         {
            return;
         }
         this.var_234.handleUserBannedMessage(_loc2_.message);
      }
      
      private function onHotelClosing(param1:IMessageEvent) : void
      {
         var _loc2_:InfoHotelClosingMessageParser = (param1 as InfoHotelClosingMessageEvent).getParser();
         if(_loc2_ == null || this.var_234 == null)
         {
            return;
         }
         this.var_234.handleHotelClosingMessage(_loc2_.minutesUntilClosing);
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:InfoHotelClosedMessageParser = (param1 as InfoHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || this.var_234 == null)
         {
            return;
         }
         this.var_234.handleHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute,_loc2_.userThrownOutAtClose);
      }
      
      private function onLoginFailedHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:LoginFailedHotelClosedMessageParser = (param1 as LoginFailedHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || this.var_234 == null)
         {
            return;
         }
         this.var_234.handleLoginFailedHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute);
      }
      
      private function onParkBusMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:ParkBusCannotEnterMessageParser = (param1 as ParkBusCannotEnterMessageEvent).getParser();
         if(this.var_832 == null)
         {
            this.var_832 = new ParkBusDialogManager(this._windowManager,assets,this._localization);
         }
         if(_loc2_ != null || this.var_832 != null)
         {
            this.var_832.handleParkBusCannotEnter(_loc2_.reason);
         }
      }
      
      private function onPetLevelNotification(param1:PetLevelNotificationEvent) : void
      {
         var _loc4_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:PetLevelNotificationParser = param1.getParser();
         this._localization.registerParameter("notifications.text.petlevel","pet_name",_loc2_.petName);
         this._localization.registerParameter("notifications.text.petlevel","level",_loc2_.level.toString());
         var _loc3_:ILocalization = this._localization.getLocalization("notifications.text.petlevel");
         if(_loc3_)
         {
            _loc4_ = this.getPetImage(_loc2_.petType,_loc2_.breed,_loc2_.color);
            this.addItem(_loc3_.value,NotificationType.const_1221,_loc4_);
         }
      }
      
      private function onPetReceived(param1:PetReceivedMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:PetReceivedMessageParser = param1.getParser();
         if(_loc2_.boughtAsGift)
         {
            _loc3_ = this._localization.getLocalization("notifications.text.petbought");
         }
         else
         {
            _loc3_ = this._localization.getLocalization("notifications.text.petreceived");
         }
         if(_loc3_)
         {
            _loc4_ = _loc2_.pet;
            _loc5_ = this.getPetImage(_loc4_.type,_loc4_.breed,_loc4_.color);
            this.addItem(_loc3_.value,NotificationType.const_1221,_loc5_);
         }
      }
      
      private function getPetImage(param1:int, param2:int, param3:String) : BitmapData
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc4_:* = null;
         if(param1 < 0 || param2 < 0)
         {
            return _loc4_;
         }
         if(param1 < 8)
         {
            _loc5_ = uint(parseInt(param3,16));
            _loc6_ = this.var_523.createPetImage(param1,param2,_loc5_,AvatarScaleType.const_56);
            if(_loc6_ != null)
            {
               _loc6_.setDirection(AvatarSetType.const_35,3);
               _loc4_ = _loc6_.getCroppedImage(AvatarSetType.const_51);
               _loc6_.dispose();
            }
         }
         else
         {
            _loc7_ = 0;
            _loc8_ = this._roomEngine.getPetImage(param1,param2,new Vector3d(135),32,null,_loc7_);
            if(_loc8_ != null)
            {
               _loc4_ = _loc8_.data;
            }
         }
         return _loc4_;
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         if(!this.var_2806)
         {
            _loc2_ = this._localization.getKey("mod.chatdisclaimer","NA");
            this.addItem(_loc2_,NotificationType.const_866,null);
            this.var_2806 = true;
            Logger.log("DISPLAYED MOD INFO: " + _loc2_);
         }
      }
      
      private function onBroadcastMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:HabboBroadcastMessageParser = (param1 as HabboBroadcastMessageEvent).getParser();
         var _loc3_:String = _loc2_.messageText;
         var _loc4_:RegExp = /\\r/g;
         _loc3_ = _loc3_.replace(_loc4_,"\r");
         this._windowManager.alert("${notifications.broadcast.title}",_loc3_,0,this.onAlert);
      }
      
      private function onPetRespectFailed(param1:IMessageEvent) : void
      {
         var _loc2_:PetRespectFailedParser = (param1 as PetRespectFailedEvent).getParser();
         this._localization.registerParameter("room.error.pets.respectfailed","required_age","" + _loc2_.requiredDays);
         this._localization.registerParameter("room.error.pets.respectfailed","avatar_age","" + _loc2_.avatarAgeInDays);
         this._windowManager.alert("${error.title}","${room.error.pets.respectfailed}",0,this.onAlert);
      }
      
      public function onAlert(param1:IAlertDialog, param2:WindowEvent) : void
      {
         if(param2.type == WindowEvent.const_183 || param2.type == WindowEvent.const_545)
         {
            param1.dispose();
         }
      }
      
      private function onClubGiftNotification(param1:ClubGiftNotificationEvent) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:ClubGiftNotificationParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.numGifts < 1)
         {
            return;
         }
         if(this.var_1046 && this.var_1046.visible)
         {
            return;
         }
         this.var_1046 = new ClubGiftNotification(_loc2_.numGifts,assets,this._windowManager,this._catalog);
      }
      
      private function onClubGiftSelected(param1:ClubGiftSelectedEvent) : void
      {
         if(!param1 || !this._localization)
         {
            return;
         }
         var _loc2_:ClubGiftSelectedParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = _loc2_.products;
         if(!_loc3_ || _loc3_.length == 0)
         {
            return;
         }
         var _loc4_:CatalogPageMessageProductData = _loc3_[0] as CatalogPageMessageProductData;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:String = this._localization.getKey("notifications.text.club_gift.received");
         var _loc6_:BitmapData = this.getProductImage(_loc4_.productType,_loc4_.furniClassId,_loc4_.extraParam);
         this.addItem(_loc5_,NotificationType.const_866,_loc6_);
      }
   }
}
