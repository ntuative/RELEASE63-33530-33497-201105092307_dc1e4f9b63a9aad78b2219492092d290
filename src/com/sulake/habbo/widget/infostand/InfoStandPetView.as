package com.sulake.habbo.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class InfoStandPetView
   {
      
      private static const const_1559:int = 152;
      
      private static const const_1554:int = 16;
      
      private static const const_684:int = 4;
      
      private static const const_1558:uint = 14342874;
      
      private static const const_1557:uint = 3815994;
      
      private static const const_1556:uint = 2085362;
      
      private static const const_1563:uint = 39616;
      
      private static const const_1560:uint = 10513106;
      
      private static const const_1555:uint = 8734654;
      
      private static const const_1562:uint = 9094430;
      
      private static const const_1561:uint = 6200576;
      
      private static const const_1553:String = "happiness";
      
      private static const const_1551:String = "experience";
      
      private static const const_1550:String = "energy";
      
      private static const const_1552:int = 250;
      
      private static const const_1086:int = 25;
      
      private static const const_1087:int = 5;
       
      
      private var _catalog:IHabboCatalog;
      
      private var _habboTracking:IHabboTracking;
      
      private var _widget:InfostandWidget;
      
      private var _window:IItemListWindow;
      
      private var var_45:IBorderWindow;
      
      private var var_94:IWindowContainer;
      
      private var var_51:IItemListWindow;
      
      private var var_213:PetCommandTool;
      
      private var _petData:Map;
      
      private var var_539:int;
      
      public function InfoStandPetView(param1:InfostandWidget, param2:String, param3:IHabboCatalog)
      {
         super();
         this._widget = param1;
         this._catalog = param3;
         this._habboTracking = HabboTracking.getInstance();
         this.createWindow(param2);
         this._petData = new Map();
      }
      
      public function dispose() : void
      {
         this._widget = null;
         this._catalog = null;
         this._habboTracking = null;
         this.var_45 = null;
         this.var_94 = null;
         this.var_51 = null;
         if(this._window)
         {
            this._window.dispose();
         }
         this._window = null;
         if(this.var_213)
         {
            this.var_213.dispose();
         }
         this.var_213 = null;
         if(this._petData)
         {
            this._petData.dispose();
            this._petData = null;
         }
      }
      
      public function get window() : IItemListWindow
      {
         return this._window;
      }
      
      private function method_1() : void
      {
         if(this.var_51 == null || this.var_45 == null || this.var_94 == null)
         {
            return;
         }
         this.var_94.width = this.var_94.width;
         this.var_94.visible = this.var_94.width > 0;
         this.var_51.height = this.var_51.scrollableRegion.height;
         this.var_45.height = this.var_51.height + 20;
         this._window.width = Math.max(this.var_45.width,this.var_94.width);
         this._window.height = this._window.scrollableRegion.height;
         if(this.var_45.width < this.var_94.width)
         {
            this.var_45.x = this._window.width - this.var_45.width;
            this.var_94.x = 0;
         }
         else
         {
            this.var_94.x = this._window.width - this.var_94.width;
            this.var_45.x = 0;
         }
         this._widget.refreshContainer();
      }
      
      public function update(param1:InfoStandPetData) : void
      {
         this.name = param1.name;
         this.image = param1.image;
         this.ownerName = param1.ownerName;
         this.raceText = this._widget.localizations.getKey(this.getRaceLocalizationKey(param1.type,param1.race));
         this.petRespect = param1.petRespect;
         this.ageText = param1.age;
         this.setLevelText(param1.level,param1.levelMax);
         this.updateStateElement(const_1553,param1.nutrition,param1.nutritionMax,const_1563,const_1556);
         this.updateStateElement(const_1551,param1.experience,param1.experienceMax,const_1555,const_1560);
         this.updateStateElement(const_1550,param1.energy,param1.energyMax,const_1561,const_1562);
         this.showButton("pick",param1.isOwnPet);
         this.showButton("train",param1.isOwnPet);
         this.showButton("kick",param1.canOwnerBeKicked);
         this.updateRespectButton();
         this.method_1();
         this.var_539 = param1.id;
         this._petData.remove(param1.id);
         this._petData.add(param1.id,param1);
         if(this.var_213 && this.var_213.isVisible() && param1.isOwnPet)
         {
            this.var_213.showCommandToolForPet(param1.id,param1.name,param1.image);
         }
      }
      
      public function getCurrentPetId() : int
      {
         return this.var_539;
      }
      
      public function updateEnabledTrainingCommands(param1:int, param2:CommandConfiguration) : void
      {
         if(this.var_213 == null)
         {
            return;
         }
         this.var_213.setEnabledCommands(param1,param2);
      }
      
      private function getRaceLocalizationKey(param1:int, param2:int) : String
      {
         return "pet.breed." + param1 + "." + param2;
      }
      
      private function createPercentageBar(param1:int, param2:int, param3:uint, param4:uint) : BitmapData
      {
         param2 = Math.max(param2,1);
         param1 = Math.max(param1,0);
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc5_:Number = param1 / param2;
         var _loc7_:BitmapData = new BitmapData(const_1559,const_1554,false);
         _loc7_.fillRect(new Rectangle(0,0,_loc7_.width,_loc7_.height),const_1558);
         var _loc8_:Rectangle = new Rectangle(1,1,_loc7_.width - 2,_loc7_.height - 2);
         _loc7_.fillRect(_loc8_,const_1557);
         var _loc9_:Rectangle = new Rectangle(1,1 + const_684,_loc7_.width - 2,_loc7_.height - 2 - const_684);
         _loc9_.width = _loc5_ * _loc9_.width;
         _loc7_.fillRect(_loc9_,param3);
         var _loc10_:Rectangle = new Rectangle(1,1,_loc7_.width - 2,const_684);
         _loc10_.width = _loc5_ * _loc10_.width;
         _loc7_.fillRect(_loc10_,param4);
         return _loc7_;
      }
      
      private function openTrainView() : void
      {
         if(this.var_213 == null)
         {
            this.var_213 = new PetCommandTool(this._widget);
         }
         var _loc1_:InfoStandPetData = this._petData.getValue(this.var_539) as InfoStandPetData;
         if(_loc1_ != null)
         {
            this.var_213.showWindow(true);
            this.var_213.showCommandToolForPet(_loc1_.id,_loc1_.name,_loc1_.image);
         }
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc2_:XmlAsset = this._widget.assets.getAssetByName("pet_view") as XmlAsset;
         this._window = this._widget.windowManager.buildFromXML(_loc2_.content as XML) as IItemListWindow;
         if(this._window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         this.var_45 = this._window.getListItemByName("info_border") as IBorderWindow;
         if(this.var_45 != null)
         {
            this.var_51 = this.var_45.findChildByName("infostand_element_list") as IItemListWindow;
         }
         this._window.name = param1;
         this._widget.mainContainer.addChild(this._window);
         var _loc3_:IWindow = this.var_45.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onClose);
         }
         this.var_94 = this._window.getListItemByName("button_list") as IWindowContainer;
         if(this.var_94 == null)
         {
            return;
         }
         var _loc4_:* = [];
         this.var_94.groupChildrenWithTag("CMD_BUTTON",_loc4_,true);
         for each(_loc5_ in _loc4_)
         {
            _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onButtonClicked);
         }
         _loc6_ = this.var_45.findChildByName("petrespect_icon") as IBitmapWrapperWindow;
         if(_loc6_ != null)
         {
            _loc11_ = this._widget.assets.getAssetByName("icon_petrespect") as BitmapDataAsset;
            _loc12_ = _loc11_.content as BitmapData;
            _loc6_.bitmap = _loc12_.clone();
         }
         var _loc7_:IBitmapWrapperWindow = this.var_45.findChildByName("status_happiness_icon") as IBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            _loc13_ = this._widget.assets.getAssetByName("icon_pet_happiness") as BitmapDataAsset;
            _loc14_ = _loc13_.content as BitmapData;
            _loc7_.bitmap = _loc14_.clone();
         }
         var _loc8_:IBitmapWrapperWindow = this.var_45.findChildByName("status_experience_icon") as IBitmapWrapperWindow;
         if(_loc8_ != null)
         {
            _loc15_ = this._widget.assets.getAssetByName("icon_pet_experience") as BitmapDataAsset;
            _loc16_ = _loc15_.content as BitmapData;
            _loc8_.bitmap = _loc16_.clone();
         }
         var _loc9_:IBitmapWrapperWindow = this.var_45.findChildByName("status_energy_icon") as IBitmapWrapperWindow;
         if(_loc9_ != null)
         {
            _loc17_ = this._widget.assets.getAssetByName("icon_pet_energy") as BitmapDataAsset;
            _loc18_ = _loc17_.content as BitmapData;
            _loc9_.bitmap = _loc18_.clone();
         }
         for each(_loc10_ in _loc4_)
         {
            if(_loc10_.parent)
            {
               _loc10_.parent.width = _loc10_.width;
            }
            _loc10_.addEventListener(WindowEvent.const_41,this.onButtonResized);
         }
      }
      
      private function set name(param1:String) : void
      {
         if(this.var_51 == null)
         {
            return;
         }
         var _loc2_:ITextWindow = this.var_51.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      private function set image(param1:BitmapData) : void
      {
         if(this.var_51 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = this.var_51.getListItemByName("image_container") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = _loc2_.findChildByName("avatar_image") as IBitmapWrapperWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         var _loc5_:Point = new Point(0,0);
         _loc5_.x = Math.round((_loc3_.width - param1.width) / 2);
         _loc5_.y = Math.round((_loc3_.height - param1.height) / 2);
         _loc4_.copyPixels(param1,param1.rect,_loc5_);
         _loc3_.bitmap = _loc4_;
         _loc3_.invalidate();
         this.method_1();
      }
      
      private function setLevelText(param1:int, param2:int) : void
      {
         if(this.var_51 == null)
         {
            return;
         }
         var _loc3_:IWindowContainer = this.var_51.getListItemByName("level_container") as IWindowContainer;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:ITextWindow = _loc3_.findChildByName("level_text") as ITextWindow;
         if(_loc4_ == null)
         {
            return;
         }
         this._widget.localizations.registerParameter("pet.level","level",param1.toString());
         this._widget.localizations.registerParameter("pet.level","maxlevel",param2.toString());
         this.method_1();
      }
      
      private function set ownerName(param1:String) : void
      {
         this._widget.localizations.registerParameter("infostand.text.petowner","name",param1);
         this.method_1();
      }
      
      private function set raceText(param1:String) : void
      {
         if(this.var_51 == null)
         {
            return;
         }
         var _loc2_:ITextWindow = this.var_51.getListItemByName("race_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         this.method_1();
      }
      
      private function set ageText(param1:int) : void
      {
         if(this.var_51 == null)
         {
            return;
         }
         var _loc2_:ITextWindow = this.var_51.getListItemByName("age_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         this._widget.localizations.registerParameter("pet.age","age",param1.toString());
         this.method_1();
      }
      
      private function set petRespect(param1:int) : void
      {
         this._widget.localizations.registerParameter("infostand.text.petrespect","count",param1.toString());
         if(this.var_51 == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = this.var_51.getListItemByName("petrespect_container") as IWindowContainer;
         var _loc3_:ITextWindow = _loc2_.findChildByName("petrespect_text") as ITextWindow;
         var _loc4_:IBitmapWrapperWindow = _loc2_.findChildByName("petrespect_icon") as IBitmapWrapperWindow;
         _loc4_.x = _loc3_.x + _loc3_.width + 2;
         this.method_1();
      }
      
      private function updateStateElement(param1:String, param2:int, param3:int, param4:uint, param5:uint) : void
      {
         var _loc9_:* = null;
         if(this.var_51 == null)
         {
            return;
         }
         var _loc6_:IWindowContainer = this.var_51.getListItemByName("status_container") as IWindowContainer;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:ITextWindow = _loc6_.findChildByName("status_" + param1 + "_value_text") as ITextWindow;
         if(_loc7_ != null)
         {
            _loc7_.text = param2 + "/" + param3;
         }
         var _loc8_:IBitmapWrapperWindow = _loc6_.findChildByName("status_" + param1 + "_bitmap") as IBitmapWrapperWindow;
         if(_loc8_ != null)
         {
            _loc9_ = this.createPercentageBar(param2,param3,param4,param5);
            if(_loc9_ != null)
            {
               _loc8_.bitmap = _loc9_;
               _loc8_.width = _loc9_.width;
               _loc8_.height = _loc9_.height;
               _loc8_.invalidate();
            }
         }
         this.method_1();
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:IWindow = param1.target as IWindow;
         switch(_loc4_.name)
         {
            case "btn_pick":
               _loc3_ = "null";
               if(this.var_213 && this.var_213.getPetId() == this.var_539)
               {
                  this.var_213.showWindow(false);
               }
               break;
            case "btn_train":
               this.openTrainView();
               break;
            case "btn_buy_food":
               if(this._catalog)
               {
                  this._catalog.openCatalogPage(CatalogPageName.const_1589,true);
                  if(this._habboTracking && !this._habboTracking.disposed)
                  {
                     this._habboTracking.track("infostandBuyPetFoodButton","click");
                  }
               }
               break;
            case "btn_petrespect":
               --this._widget.userData.petRespectLeft;
               this.updateRespectButton();
               _loc3_ = "null";
               break;
            case "btn_kick":
               _loc2_ = new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.const_431,this._widget.petData.ownerId);
               this._widget.messageListener.processWidgetMessage(_loc2_);
               return;
         }
         if(_loc3_ != null)
         {
            _loc5_ = this._widget.petData.id;
            _loc2_ = new RoomWidgetUserActionMessage(_loc3_,_loc5_);
            this._widget.messageListener.processWidgetMessage(_loc2_);
         }
         this.method_1();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         this._widget.close();
      }
      
      private function updateRespectButton() : void
      {
         var _loc1_:int = this._widget.userData.petRespectLeft;
         this._widget.localizations.registerParameter("infostand.button.petrespect","count",_loc1_.toString());
         this.showButton("petrespect",_loc1_ > 0);
      }
      
      protected function showButton(param1:String, param2:Boolean) : void
      {
         if(this.var_94 == null)
         {
            return;
         }
         var _loc3_:IWindow = this.var_94.getChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            this.arrangeButtons();
         }
      }
      
      protected function onButtonResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.window.parent;
         if(_loc2_ && _loc2_.tags.indexOf("CMD_BUTTON_REGION") > -1)
         {
            _loc2_.width = param1.window.width;
         }
      }
      
      private function arrangeButtons() : void
      {
         var _loc5_:* = null;
         var _loc1_:int = const_1552;
         this.var_94.width = _loc1_;
         var _loc2_:* = [];
         this.var_94.groupChildrenWithTag("CMD_BUTTON_REGION",_loc2_,true);
         var _loc3_:int = _loc1_;
         var _loc4_:int = 0;
         for each(_loc5_ in _loc2_)
         {
            if(_loc5_.visible)
            {
               if(_loc3_ - _loc5_.width < 0)
               {
                  _loc3_ = _loc1_;
                  _loc4_ += const_1086 + const_1087;
               }
               _loc5_.x = _loc3_ - _loc5_.width;
               _loc5_.y = _loc4_;
               _loc3_ = _loc5_.x - const_1087;
            }
         }
         this.var_94.height = _loc4_ + const_1086;
         this.method_1();
      }
   }
}
