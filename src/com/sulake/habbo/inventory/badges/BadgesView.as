package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgesView implements IInventoryView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _view:IWindowContainer;
      
      private var var_65:BadgesModel;
      
      private var var_1200:IItemGridWindow;
      
      private var var_1199:IItemGridWindow;
      
      private var _disposed:Boolean = false;
      
      public function BadgesView(param1:BadgesModel, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         this.var_65 = param1;
         this._assetLibrary = param3;
         this._windowManager = param2;
         var _loc4_:IAsset = this._assetLibrary.getAssetByName("inventory_badges_xml");
         var _loc5_:XmlAsset = XmlAsset(_loc4_);
         this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_loc5_.content)));
         this._view.visible = false;
         this._view.procedure = this.windowEventProc;
         this.var_1200 = this._view.findChildByName("inactive_items") as IItemGridWindow;
         this.var_1200.procedure = this.inactiveGridEventProc;
         this.var_1199 = this._view.findChildByName("active_items") as IItemGridWindow;
         this.var_1199.procedure = this.activeGridEventProc;
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
            this._disposed = true;
         }
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
      
      public function updateAll() : void
      {
         this.updateListViews();
         this.updateActionView();
      }
      
      private function updateListViews() : void
      {
         var _loc2_:* = null;
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         this.var_1200.removeGridItems();
         this.var_1199.removeGridItems();
         var _loc1_:Array = this.var_65.getBadges(0);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as Badge;
            if(!_loc2_.isInUse)
            {
               this.var_1200.addGridItem(_loc2_.window);
               _loc2_.window.procedure = this.inactiveGridEventProc;
            }
            _loc3_++;
         }
         var _loc4_:Array = this.var_65.getBadges(1);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as Badge;
            this.var_1199.addGridItem(_loc2_.window);
            _loc2_.window.procedure = this.activeGridEventProc;
            _loc3_++;
         }
      }
      
      private function updateActionView() : void
      {
         var _loc3_:* = null;
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc1_:IButtonWindow = this._view.findChildByName("wearBadge_button") as IButtonWindow;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:Badge = this.var_65.getSelectedBadge();
         if(_loc2_ == null)
         {
            _loc1_.disable();
            this.setBadgeName(null);
            this.setBadgeDescriptionText(null);
            this.setBadgeDescriptionImage(null);
         }
         else
         {
            if(_loc2_.isInUse)
            {
               _loc1_.caption = "${inventory.badges.clearbadge}";
            }
            else
            {
               _loc1_.caption = "${inventory.badges.wearbadge}";
            }
            this.setBadgeName(this.var_65.controller.localization.getBadgeName(_loc2_.type));
            this.setBadgeDescriptionText(this.var_65.controller.localization.getBadgeDesc(_loc2_.type));
            this.setBadgeDescriptionImage(_loc2_.iconImage);
            _loc3_ = this.var_65.getBadges(1);
            if(_loc3_ != null && _loc3_.length >= this.var_65.getMaxActiveCount() && !_loc2_.isInUse)
            {
               _loc1_.disable();
            }
            else
            {
               _loc1_.enable();
            }
         }
      }
      
      private function setBadgeDescriptionImage(param1:BitmapData) : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = this._view.findChildByName("badgeDescriptionImage") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap != null)
         {
            _loc2_.bitmap.dispose();
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc2_.bitmap.fillRect(_loc2_.bitmap.rect,0);
         if(param1 == null)
         {
            param1 = new BitmapData(_loc2_.width,_loc2_.height);
         }
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         _loc2_.invalidate();
      }
      
      private function setBadgeName(param1:String) : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc2_:ITextWindow = this._view.findChildByName("badgeName") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function setBadgeDescriptionText(param1:String) : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc2_:ITextWindow = this._view.findChildByName("badgeDescriptionText") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "${inventory.effects.defaultdescription}";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function inactiveGridEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc3_ = this.var_1200.getGridItemIndex(param1.window);
            _loc4_ = this.var_65.getBadgeFromInactive(_loc3_);
            if(_loc4_ != null)
            {
               this.var_65.setBadgeSelected(_loc4_.type);
            }
         }
      }
      
      private function activeGridEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc3_ = this.var_1199.getGridItemIndex(param1.window);
            _loc4_ = this.var_65.getBadgeFromActive(_loc3_);
            if(_loc4_ != null)
            {
               this.var_65.setBadgeSelected(_loc4_.type);
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            switch(param2.name)
            {
               case "wearBadge_button":
                  _loc3_ = this.var_65.getSelectedBadge();
                  if(_loc3_ != null)
                  {
                     this.var_65.toggleBadgeWearing(_loc3_.type);
                  }
            }
         }
      }
   }
}
