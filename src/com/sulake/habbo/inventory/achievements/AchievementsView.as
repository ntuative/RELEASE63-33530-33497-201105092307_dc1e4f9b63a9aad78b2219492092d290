package com.sulake.habbo.inventory.achievements
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AchievementsView implements IInventoryView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_370:ISessionDataManager;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _view:IWindowContainer;
      
      private var var_65:AchievementsModel;
      
      private var var_1101:Dictionary;
      
      private var _list:IItemListWindow;
      
      private var var_470:Timer;
      
      private var _disposed:Boolean = false;
      
      public function AchievementsView(param1:AchievementsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:ISessionDataManager)
      {
         this.var_1101 = new Dictionary();
         super();
         this.var_65 = param1;
         this._assetLibrary = param3;
         this._windowManager = param2;
         this.var_370 = param5;
         this._localization = param4;
         var _loc6_:IAsset = this._assetLibrary.getAssetByName("inventory_achievements_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc6_);
         this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_loc7_.content)));
         this._view.visible = false;
         this._list = IItemListWindow(this._view.getChildByName("achievements_itemlist"));
         this.var_470 = new Timer(1000,1);
         this.var_470.addEventListener(TimerEvent.TIMER,this.doBadgeRefresh);
         this.var_370.events.addEventListener(BadgeImageReadyEvent.const_115,this.onBadgeImageReady);
      }
      
      public static function hideChildren(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
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
            this._windowManager = null;
            this.var_65 = null;
            this._view = null;
            this._list = null;
            this._assetLibrary = null;
            this._localization = null;
            this.var_1101 = null;
            if(this.var_370 != null)
            {
               this.var_370.events.removeEventListener(BadgeImageReadyEvent.const_115,this.onBadgeImageReady);
               this.var_370 = null;
            }
            if(this.var_470)
            {
               this.var_470.removeEventListener(TimerEvent.TIMER,this.doBadgeRefresh);
               this.var_470.reset();
               this.var_470 = null;
            }
            this._disposed = true;
         }
      }
      
      public function updateList() : void
      {
         var _loc3_:Boolean = false;
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc1_:Array = this.var_65.getAchievements();
         this._list.autoArrangeItems = false;
         var _loc2_:int = 0;
         while(true)
         {
            if(_loc2_ < _loc1_.length)
            {
               this.refreshEntry(true,_loc2_,_loc1_[_loc2_]);
            }
            else
            {
               _loc3_ = this.refreshEntry(false,_loc2_,null);
               if(_loc3_)
               {
                  break;
               }
            }
            _loc2_++;
         }
         this._list.autoArrangeItems = true;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:AchievementData) : Boolean
      {
         var _loc4_:IWindowContainer = IWindowContainer(this._list.getListItemAt(param2));
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = this.getListEntry(param2);
            this._list.addListItem(_loc4_);
         }
         hideChildren(_loc4_);
         if(param1)
         {
            this.refreshEntryDetails(_loc4_,param3);
            _loc4_.visible = true;
         }
         else
         {
            _loc4_.height = 0;
            _loc4_.visible = false;
         }
         return false;
      }
      
      public function refreshEntryDetails(param1:IWindowContainer, param2:AchievementData) : void
      {
         this.refreshBadgeImage(param1,param2);
         var _loc3_:ITextWindow = param1.findChildByName("achievement_name") as ITextWindow;
         _loc3_.text = this._localization.getAchievementName(param2.badgeId);
         _loc3_.visible = true;
         var _loc4_:ITextWindow = param1.findChildByName("achievement_description") as ITextWindow;
         _loc4_.text = this._localization.getAchievementDesc(param2.badgeId,param2.scoreLimit);
         _loc4_.visible = true;
         var _loc5_:String = this._localization.getKey("inventory.achievements.unit." + param2.type,"");
         var _loc6_:String = "inventory.achievements.entrydetails." + param2.levelRewardPointType;
         var _loc7_:ITextWindow = param1.findChildByName("achievement_details") as ITextWindow;
         this._localization.registerParameter(_loc6_,"currentpoints","" + param2.currentPoints);
         this._localization.registerParameter(_loc6_,"scorelimit","" + param2.scoreLimit);
         this._localization.registerParameter(_loc6_,"levelrewardpoints","" + param2.levelRewardPoints);
         this._localization.registerParameter(_loc6_,"unit","" + _loc5_);
         _loc7_.text = this._localization.getKey(_loc6_);
         _loc7_.visible = true;
         _loc4_.height = _loc4_.textHeight + 5;
         _loc7_.height = _loc7_.textHeight + 5;
         _loc7_.y = _loc4_.y + _loc4_.height;
         param1.height = _loc7_.y + _loc7_.height + 5;
      }
      
      private function getListEntry(param1:int) : IWindowContainer
      {
         var _loc2_:IAsset = this._assetLibrary.getAssetByName("inventory_achievement_item_xml");
         var _loc3_:XmlAsset = XmlAsset(_loc2_);
         var _loc4_:IWindowContainer = IWindowContainer(this._windowManager.buildFromXML(XML(_loc3_.content)));
         var _loc5_:IBitmapWrapperWindow = _loc4_.findChildByName("achievement_image") as IBitmapWrapperWindow;
         _loc4_.background = true;
         _loc4_.color = param1 % 2 != 0 ? 4294967295 : uint(4292797682);
         _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
         return _loc4_;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(this._view == null)
         {
            return null;
         }
         if(this._view.disposed)
         {
            return null;
         }
         return this._view;
      }
      
      public function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         Logger.log("Got badge: " + param1.badgeId + ", " + this.var_470.running);
         this.var_1101[param1.badgeId] = param1.badgeImage;
         if(!this.var_470.running)
         {
            this.var_470.start();
         }
      }
      
      private function refreshBadgeImage(param1:IWindowContainer, param2:AchievementData) : void
      {
         var _loc3_:IBitmapWrapperWindow = param1.findChildByName("achievement_image") as IBitmapWrapperWindow;
         var _loc4_:BitmapData = this.var_1101[param2.badgeId];
         if(_loc4_ == null)
         {
            _loc4_ = this.var_370.getBadgeImage(param2.badgeId);
            this.var_1101[param2.badgeId] = _loc4_;
         }
         var _loc5_:Point = new Point((_loc3_.width - _loc4_.width) / 2,(_loc3_.height - _loc4_.height) / 2);
         _loc3_.bitmap.fillRect(_loc3_.bitmap.rect,16777215);
         _loc3_.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc5_,null,null,true);
         _loc3_.visible = true;
      }
      
      private function doBadgeRefresh(param1:TimerEvent) : void
      {
         this.var_470.reset();
         this.updateList();
         Logger.log("Now updating list...");
      }
   }
}
