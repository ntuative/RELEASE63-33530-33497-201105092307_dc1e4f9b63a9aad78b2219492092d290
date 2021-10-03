package com.sulake.habbo.roomevents.userdefinedroomevents
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ICheckBoxWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes.ActionType;
   import com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes.ActionTypes;
   import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
   import com.sulake.habbo.roomevents.userdefinedroomevents.conditions.ConditionTypes;
   import com.sulake.habbo.roomevents.userdefinedroomevents.help.UserDefinedRoomEventsHelp;
   import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.TriggerConfs;
   import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.TriggerOnce;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class UserDefinedRoomEventsCtrl
   {
      
      public static var STUFF_SELECTION_OPTION_NONE:int = 0;
      
      public static var STUFF_SELECTION_OPTION_BY_ID:int = 1;
      
      public static var STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE:int = 2;
      
      public static var var_330:int = 3;
      
      private static var var_1434:int = 2;
       
      
      private var var_80:HabboUserDefinedRoomEvents;
      
      private var _window:IFrameWindow;
      
      private var var_49:IWindowContainer;
      
      private var var_1801:TriggerConfs;
      
      private var var_1802:ActionTypes;
      
      private var var_1803:ConditionTypes;
      
      private var var_251:Dictionary;
      
      private var var_35:Triggerable;
      
      private var var_761:RoomObjectHightLighter;
      
      private var var_126:UserDefinedRoomEventsHelp;
      
      private var var_1164:SliderWindowController;
      
      public function UserDefinedRoomEventsCtrl(param1:HabboUserDefinedRoomEvents)
      {
         this.var_1801 = new TriggerConfs();
         this.var_1802 = new ActionTypes();
         this.var_1803 = new ConditionTypes();
         this.var_251 = new Dictionary();
         super();
         this.var_80 = param1;
         this.var_761 = new RoomObjectHightLighter(param1);
         this.var_126 = new UserDefinedRoomEventsHelp(param1);
      }
      
      public function stuffSelected(param1:int, param2:String) : void
      {
         if(this._window == null || !this._window.visible)
         {
            return;
         }
         if(!this.isStuffSelectionMode())
         {
            return;
         }
         if(this.var_251[param1])
         {
            delete this.var_251[param1];
            this.var_761.hide(param1);
         }
         else if(this.getStuffIds().length < this.var_35.furniLimit)
         {
            this.var_251[param1] = param2;
            this.var_761.show(param1);
         }
         this.refresh();
      }
      
      private function isStuffSelectionMode() : Boolean
      {
         var _loc1_:Element = this.resolveType();
         return _loc1_.requiresFurni != STUFF_SELECTION_OPTION_NONE;
      }
      
      private function resolveType() : Element
      {
         return this.resolveHolder().getElementByCode(this.var_35.code);
      }
      
      private function resolveHolder() : ElementTypeHolder
      {
         if(this.var_35 as TriggerDefinition != null)
         {
            return this.var_1801;
         }
         if(this.var_35 as ActionDefinition != null)
         {
            return this.var_1802;
         }
         if(this.var_35 as ConditionDefinition != null)
         {
            return this.var_1803;
         }
         return null;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         this._window = IFrameWindow(this.var_80.getXmlWindow("ude_main"));
         this.var_49 = IWindowContainer(this.find(this._window,"configure_container"));
         Util.setProcDirectly(this.find(this.var_49,"save_button"),this.onSave);
         Util.setProcDirectly(this.find(this.var_49,"cancel_save_button"),this.onWindowClose);
         Util.setProcDirectly(this.find(this.var_49,"helplink"),this.onHelp);
         Util.setProcDirectly(this.find(this.var_49,"apply_snapshot_txt"),this.onApplySnapshot);
         Util.setProcDirectly(this.find(this.var_49,"dec_stuff_sel_txt"),this.method_5);
         Util.setProcDirectly(this.find(this.var_49,"inc_stuff_sel_txt"),this.onIncStuffSelectionType);
         this.find(this.var_49,"dec_stuff_sel_txt").mouseThreshold = 0;
         this.find(this.var_49,"inc_stuff_sel_txt").mouseThreshold = 0;
         this.find(this.var_49,"helplink").mouseThreshold = 0;
         this.find(this.var_49,"apply_snapshot_txt").mouseThreshold = 0;
         this.var_1164 = new SliderWindowController(this.var_80,IWindowContainer(this.find(this.var_49,"delay_slider_container")),this.var_80.assets,0,20,1);
         this.var_1164.addEventListener(Event.CHANGE,this.onDelaySliderChange);
         this.var_1164.setValue(0);
         this.setIcon("configure_container","icon_trigger","trigger_icon_bitmap");
         this.setIcon("configure_container","icon_action","action_icon_bitmap");
         this.setIcon("configure_container","icon_condition","condition_icon_bitmap");
         var _loc1_:IWindow = this._window.findChildByTag("close");
         _loc1_.procedure = this.onWindowClose;
         this._window.center();
      }
      
      private function onDelaySliderChange(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1.type == Event.CHANGE)
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               _loc4_ = int(_loc3_);
               _loc5_ = TriggerOnce.getSecsFromPulses(_loc4_);
               this.var_80.localization.registerParameter("wiredfurni.params.delay","seconds",_loc5_);
            }
         }
      }
      
      private function setIcon(param1:String, param2:String, param3:String = "icon_bitmap") : void
      {
         var _loc4_:IWindowContainer = IWindowContainer(this.find(this._window,param1));
         this.var_80.refreshButton(_loc4_,param3,true,null,0,param2);
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.close();
         }
      }
      
      public function close() : void
      {
         if(this._window)
         {
            this._window.visible = false;
            this.var_761.hideAll(this.var_251);
         }
      }
      
      private function find(param1:IWindowContainer, param2:String) : IWindow
      {
         var _loc3_:IWindow = param1.findChildByName(param2);
         if(_loc3_ == null)
         {
            throw new Error("Window element with name: " + param2 + " cannot be found!");
         }
         return _loc3_;
      }
      
      public function prepareForUpdate(param1:Triggerable) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         this.prepareWindow();
         this.var_35 = param1;
         Logger.log("Received: " + this.var_35 + ", " + param1.code);
         var _loc2_:Element = this.resolveType();
         this.var_761.hideAll(this.var_251);
         this.var_251 = new Dictionary();
         for each(_loc3_ in this.var_35.stuffIds)
         {
            this.var_251[_loc3_] = "yes";
         }
         _loc4_ = !!_loc2_.hasSpecialInputs ? this.prepareCustomInput() : null;
         _loc2_.onEditStart(_loc4_,this.var_35);
         this.var_761.showAll(this.var_251);
         if(this.var_35 as ActionDefinition != null)
         {
            _loc5_ = ActionDefinition(this.var_35);
            _loc6_ = _loc5_.delayInPulses;
            this.var_1164.setValue(_loc6_);
         }
         this.prepareStuffSelectionForUpdate();
         this.refresh();
      }
      
      private function prepareStuffSelectionForUpdate() : void
      {
         var _loc2_:* = null;
         this.getFurniTypeMatchesCheckBox().visible = false;
         this.getFurniTypeMatchesText().visible = false;
         this.getIncStuffSelTxt().visible = false;
         this.getDecStuffSelTxt().visible = false;
         if(this.var_35.stuffTypeSelectionEnabled)
         {
            _loc2_ = this.resolveType();
            if(_loc2_.requiresFurni == STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE)
            {
               if(this.var_35.stuffTypeSelectionCode == 1)
               {
                  this.getFurniTypeMatchesCheckBox().select();
               }
               else
               {
                  this.getFurniTypeMatchesCheckBox().unselect();
               }
               this.getFurniTypeMatchesText().caption = this.var_80.localization.getKey("wiredfurni.pickfurnis.furnitypematches");
               this.getFurniTypeMatchesCheckBox().visible = true;
               this.getFurniTypeMatchesText().visible = true;
            }
            else if(_loc2_.requiresFurni == var_330)
            {
               this.getIncStuffSelTxt().visible = true;
               this.getDecStuffSelTxt().visible = true;
               this.getFurniTypeMatchesText().visible = true;
               this.refreshStuffTypeSelectionToggler();
            }
         }
         var _loc1_:IWindowContainer = IWindowContainer(this.var_49.findChildByName("select_furni_container"));
         _loc1_.height = Util.getLowestPoint(_loc1_);
      }
      
      private function refreshStuffTypeSelectionToggler() : void
      {
         this.getFurniTypeMatchesText().caption = this.var_80.localization.getKey("wiredfurni.pickfurnis.stuffselectiontype." + this.var_35.stuffTypeSelectionCode);
      }
      
      public function stuffRemoved(param1:int) : void
      {
         if(this._window == null)
         {
            return;
         }
         if(!this._window.visible)
         {
            return;
         }
         if(this.var_35.id == param1)
         {
            this._window.visible = false;
            return;
         }
         if(this.var_251[param1])
         {
            delete this.var_251[param1];
            this.refresh();
         }
      }
      
      private function onSave(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(this.isStuffSelectionMode())
         {
            this.var_761.hideAll(this.var_251);
         }
         if(this.var_35 as TriggerDefinition != null)
         {
            this.var_80.send(new UpdateTriggerMessageComposer(this.var_35.id,this.resolveIntParams(),this.resolveStringParam(),this.getStuffIds(),this.resolveStuffSelectionType()));
         }
         else if(this.var_35 as ActionDefinition != null)
         {
            this.var_80.send(new UpdateActionMessageComposer(this.var_35.id,this.resolveIntParams(),this.resolveStringParam(),this.getStuffIds(),this.getActionDelay(),this.resolveStuffSelectionType()));
         }
         else if(this.var_35 as ConditionDefinition != null)
         {
            this.var_80.send(new UpdateConditionMessageComposer(this.var_35.id,this.resolveIntParams(),this.resolveStringParam(),this.getStuffIds(),this.resolveStuffSelectionType()));
         }
         this.close();
      }
      
      public function getActionDelay() : int
      {
         var _loc1_:ActionType = ActionType(this.resolveType());
         return !!_loc1_.allowDelaying ? int(this.var_1164.getValue()) : 0;
      }
      
      private function onHelp(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.var_126.open(this._window.x + this._window.width + 5,this._window.y);
      }
      
      private function method_5(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.var_35.stuffTypeSelectionCode = this.var_35.stuffTypeSelectionCode < 1 ? int(var_1434) : int(this.var_35.stuffTypeSelectionCode - 1);
         this.refreshStuffTypeSelectionToggler();
      }
      
      private function onIncStuffSelectionType(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.var_35.stuffTypeSelectionCode = (this.var_35.stuffTypeSelectionCode + 1) % (var_1434 + 1);
         this.refreshStuffTypeSelectionToggler();
      }
      
      private function onApplySnapshot(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.var_80.send(new ApplySnapshotMessageComposer(this.var_35.id));
      }
      
      private function resolveIntParams() : Array
      {
         var _loc1_:Element = this.resolveType();
         var _loc2_:IWindowContainer = !!_loc1_.hasSpecialInputs ? this.prepareCustomInput() : null;
         return _loc1_.readIntParamsFromForm(_loc2_);
      }
      
      private function resolveStringParam() : String
      {
         var _loc1_:Element = this.resolveType();
         var _loc2_:IWindowContainer = !!_loc1_.hasSpecialInputs ? this.prepareCustomInput() : null;
         return _loc1_.readStringParamFromForm(_loc2_);
      }
      
      private function resolveStuffSelectionType() : int
      {
         if(!this.var_35.stuffTypeSelectionEnabled)
         {
            return 0;
         }
         var _loc1_:Element = this.resolveType();
         if(_loc1_.requiresFurni == STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE)
         {
            return !!this.getFurniTypeMatchesCheckBox().isSelected ? 1 : 0;
         }
         if(_loc1_.requiresFurni == var_330)
         {
            return this.var_35.stuffTypeSelectionCode;
         }
         return 0;
      }
      
      public function getStuffIds() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.var_251)
         {
            _loc1_.push(int(_loc2_));
         }
         return _loc1_;
      }
      
      private function refresh() : void
      {
         this.var_49.visible = false;
         this.refreshConfigureElement(this.var_1801);
         this.refreshConfigureElement(this.var_1802);
         this.refreshConfigureElement(this.var_1803);
         this._window.content.height = Util.getLowestPoint(this._window.content);
         this._window.visible = true;
      }
      
      private function refreshConfigureElement(param1:ElementTypeHolder) : void
      {
         if(!param1.acceptTriggerable(this.var_35))
         {
            this.find(this.var_49,param1.getKey() + "_icon_bitmap").visible = false;
            return;
         }
         this.var_49.visible = true;
         var _loc2_:Element = this.resolveType();
         this.refreshHeader(_loc2_,param1.getKey());
         this.refreshCustomInputs();
         this.refreshSelectFurni();
         this.find(this.var_49,"warning_container").visible = false;
         this.refreshConflictingTriggers();
         this.refreshConflictingActions();
         this.refreshActionInputs();
         Util.moveAllChildrenToColumn(this.var_49,3,5);
         this.var_49.height = Util.getLowestPoint(this.var_49) + 1;
      }
      
      private function getElementName(param1:int) : String
      {
         var _loc2_:IFurnitureData = this.var_80.sessionDataManager.getFloorItemData(param1);
         if(_loc2_ == null)
         {
            Logger.log("COULD NOT FIND FURNIDATA FOR " + param1);
            return "NAME: " + param1;
         }
         return _loc2_.title;
      }
      
      private function getElementDesc(param1:int) : String
      {
         var _loc2_:IFurnitureData = this.var_80.sessionDataManager.getFloorItemData(param1);
         if(_loc2_ == null)
         {
            Logger.log("COULD NOT FIND FURNIDATA FOR " + param1);
            return "NAME: " + param1;
         }
         return _loc2_.description;
      }
      
      private function setText(param1:IWindowContainer, param2:String, param3:String) : void
      {
         var _loc4_:ITextWindow = ITextWindow(this.find(param1,param2));
         _loc4_.caption = param3;
         _loc4_.height = _loc4_.textHeight + 6;
      }
      
      private function refreshHeader(param1:Element, param2:String) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(this.find(this.var_49,"header_container"));
         this.find(_loc3_,param2 + "_icon_bitmap").visible = true;
         this.setText(_loc3_,"conf_name_txt",this.getElementName(this.var_35.stuffTypeId));
         this.setText(_loc3_,"conf_desc_txt",this.getElementDesc(this.var_35.stuffTypeId));
         var _loc4_:IWindow = this.find(_loc3_,"conf_name_txt");
         var _loc5_:IWindow = this.find(_loc3_,"conf_desc_txt");
         _loc5_.y = _loc4_.y + _loc4_.height;
         var _loc6_:Element = this.resolveType();
         var _loc7_:IWindow = this.find(_loc3_,"apply_snapshot_txt");
         if(_loc6_.hasStateSnapshot)
         {
            _loc7_.visible = true;
            _loc7_.y = _loc5_.y + _loc5_.height;
         }
         else
         {
            _loc7_.visible = false;
         }
         _loc3_.height = Util.getLowestPoint(_loc3_) + 4;
      }
      
      private function refreshActionInputs() : void
      {
         var _loc1_:IWindowContainer = IWindowContainer(this.find(this.var_49,"action_inputs_container"));
         if(this.var_35 as ActionDefinition == null)
         {
            _loc1_.visible = false;
            return;
         }
         var _loc2_:ActionType = ActionType(this.resolveType());
         if(!_loc2_.allowDelaying)
         {
            _loc1_.visible = false;
            return;
         }
         _loc1_.visible = true;
      }
      
      private function refreshConflictingTriggers() : void
      {
         var _loc4_:int = 0;
         if(this.var_35 as ActionDefinition == null)
         {
            return;
         }
         var _loc1_:ActionDefinition = ActionDefinition(this.var_35);
         if(_loc1_.conflictingTriggers.length < 1)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:Boolean = true;
         for each(_loc4_ in _loc1_.conflictingTriggers)
         {
            _loc2_ += (!!_loc3_ ? "" : ", ") + "\'" + this.getElementName(_loc4_) + "\'";
            _loc3_ = false;
         }
         this.var_80.localization.registerParameter("wiredfurni.conflictingtriggers.text","triggers",_loc2_);
         this.refreshWarning(this.var_80.localization.getKey("wiredfurni.conflictingtriggers.caption"),this.var_80.localization.getKey("wiredfurni.conflictingtriggers.text"));
      }
      
      private function refreshConflictingActions() : void
      {
         var _loc4_:int = 0;
         if(this.var_35 as TriggerDefinition == null)
         {
            return;
         }
         var _loc1_:TriggerDefinition = TriggerDefinition(this.var_35);
         if(_loc1_.conflictingActions.length < 1)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:Boolean = true;
         for each(_loc4_ in _loc1_.conflictingActions)
         {
            _loc2_ += (!!_loc3_ ? "" : ", ") + "\'" + this.getElementName(_loc4_) + "\'";
            _loc3_ = false;
         }
         this.var_80.localization.registerParameter("wiredfurni.conflictingactions.text","actions",_loc2_);
         this.refreshWarning(this.var_80.localization.getKey("wiredfurni.conflictingactions.caption"),this.var_80.localization.getKey("wiredfurni.conflictingactions.text"));
      }
      
      private function refreshWarning(param1:String, param2:String) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(this.find(this.var_49,"warning_container"));
         this.setText(_loc3_,"caption_txt",param1);
         this.setText(_loc3_,"desc_txt",param2);
         var _loc4_:IWindow = this.find(_loc3_,"caption_txt");
         this.find(_loc3_,"desc_txt").y = _loc4_.y + _loc4_.height;
         _loc3_.height = Util.getLowestPoint(_loc3_) + 4;
         this.find(this.var_49,"warning_container").visible = true;
      }
      
      private function refreshCustomInputs() : void
      {
         var _loc2_:* = null;
         var _loc1_:IWindowContainer = IWindowContainer(this.var_49.findChildByName("custom_inputs_container"));
         Util.hideChildren(_loc1_);
         if(this.resolveType().hasSpecialInputs)
         {
            _loc2_ = this.prepareCustomInput();
            _loc2_.visible = true;
         }
         _loc1_.height = Util.getLowestPoint(_loc1_);
      }
      
      private function prepareCustomInput() : IWindowContainer
      {
         var _loc1_:ElementTypeHolder = this.resolveHolder();
         var _loc2_:Element = this.resolveType();
         var _loc3_:IWindowContainer = IWindowContainer(this.var_49.findChildByName("custom_inputs_container"));
         var _loc4_:String = _loc1_.getKey() + _loc2_.code;
         var _loc5_:IWindowContainer = IWindowContainer(_loc3_.getChildByName(_loc4_));
         if(_loc5_ == null)
         {
            _loc5_ = IWindowContainer(this.var_80.getXmlWindow("ude_" + _loc1_.getKey() + "_inputs_" + _loc2_.code));
            _loc5_.name = _loc4_;
            _loc3_.addChild(_loc5_);
            _loc2_.onInit(_loc5_,this.var_80);
         }
         return _loc5_;
      }
      
      private function refreshSelectFurni() : void
      {
         var _loc1_:IWindowContainer = IWindowContainer(this.var_49.findChildByName("select_furni_container"));
         if(!this.isStuffSelectionMode())
         {
            _loc1_.visible = false;
            return;
         }
         _loc1_.visible = true;
         var _loc2_:IWindow = _loc1_.findChildByName("furni_name_txt");
         var _loc3_:int = this.getStuffIds().length;
         var _loc4_:int = this.var_35.furniLimit;
         this.var_80.localization.registerParameter("wiredfurni.pickfurnis.caption","count","" + _loc3_);
         this.var_80.localization.registerParameter("wiredfurni.pickfurnis.caption","limit","" + _loc4_);
      }
      
      private function getFurniTypeMatchesCheckBox() : ICheckBoxWindow
      {
         return ICheckBoxWindow(this.var_49.findChildByName("furni_type_matches_checkbox"));
      }
      
      private function getDecStuffSelTxt() : IWindow
      {
         return this.var_49.findChildByName("dec_stuff_sel_txt");
      }
      
      private function getIncStuffSelTxt() : IWindow
      {
         return this.var_49.findChildByName("inc_stuff_sel_txt");
      }
      
      private function getFurniTypeMatchesText() : IWindow
      {
         return this.var_49.findChildByName("furni_type_matches_txt");
      }
   }
}
