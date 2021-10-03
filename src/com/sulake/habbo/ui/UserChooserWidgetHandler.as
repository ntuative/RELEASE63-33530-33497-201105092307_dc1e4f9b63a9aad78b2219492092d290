package com.sulake.habbo.ui
{
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.ChooserItem;
   import com.sulake.habbo.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class UserChooserWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1076:Boolean = false;
      
      public function UserChooserWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1076;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_364;
      }
      
      public function dispose() : void
      {
         this.var_1076 = true;
         this._container = null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetRequestWidgetMessage.REQUEST_USER_CHOOSER);
         _loc1_.push(RoomWidgetRoomObjectMessage.const_400);
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetRequestWidgetMessage.REQUEST_USER_CHOOSER:
               this.handleUserChooserRequest();
               break;
            case RoomWidgetRoomObjectMessage.const_400:
               _loc2_ = param1 as RoomWidgetRoomObjectMessage;
               if(_loc2_ == null)
               {
                  return null;
               }
               this._container.roomEngine.selectRoomObject(this._container.roomSession.roomId,this._container.roomSession.roomCategory,_loc2_.id,_loc2_.category);
               break;
         }
         return null;
      }
      
      private function compareItems(param1:ChooserItem, param2:ChooserItem) : int
      {
         if(param1 == null || param2 == null || param1.name == param2.name || param1.name.length == 0 || param2.name.length == 0)
         {
            return 1;
         }
         var _loc3_:Array = new Array(param1.name.toUpperCase(),param2.name.toUpperCase()).sort();
         if(_loc3_.indexOf(param1.name.toUpperCase()) == 0)
         {
            return -1;
         }
         return 1;
      }
      
      private function handleUserChooserRequest() : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         if(this._container == null || this._container.roomSession == null || this._container.roomEngine == null)
         {
            return;
         }
         if(this._container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc1_:int = this._container.roomSession.roomId;
         var _loc2_:int = this._container.roomSession.roomCategory;
         var _loc3_:* = [];
         var _loc5_:int = this._container.roomEngine.getRoomObjectCount(_loc1_,_loc2_,RoomObjectCategoryEnum.const_33);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._container.roomEngine.getRoomObjectWithIndex(_loc1_,_loc2_,_loc6_,RoomObjectCategoryEnum.const_33);
            _loc7_ = this._container.roomSession.userDataManager.getUserDataByIndex(_loc4_.getId());
            if(_loc7_ != null)
            {
               _loc3_.push(new ChooserItem(_loc7_.id,RoomObjectCategoryEnum.const_33,_loc7_.name));
            }
            _loc6_++;
         }
         _loc3_.sort(this.compareItems);
         this._container.events.dispatchEvent(new RoomWidgetChooserContentEvent(RoomWidgetChooserContentEvent.const_702,_loc3_));
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}
