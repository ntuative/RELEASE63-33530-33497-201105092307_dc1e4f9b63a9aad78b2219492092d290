package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitData;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomVisitsCtrl implements IDisposable, TrackedWindow
   {
      
      private static var var_1010:Array = [];
      
      private static var var_1965:int = 200;
       
      
      private var var_33:ModerationManager;
      
      private var _frame:IFrameWindow;
      
      private var _list:IItemListWindow;
      
      private var _userId:int;
      
      private var var_109:Array;
      
      private var _disposed:Boolean;
      
      private var var_807:IWindowContainer;
      
      private var var_511:Timer;
      
      private var var_1529:Array;
      
      public function RoomVisitsCtrl(param1:ModerationManager, param2:int)
      {
         this.var_1529 = [];
         super();
         this.var_33 = param1;
         this._userId = param2;
      }
      
      public static function getFormattedTime(param1:int, param2:int) : String
      {
         return padToTwoDigits(param1) + ":" + padToTwoDigits(param2);
      }
      
      public static function padToTwoDigits(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : "" + param1;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function show() : void
      {
         this.var_807 = IWindowContainer(this.var_33.getXmlWindow("roomvisits_row"));
         this.var_511 = new Timer(300,1);
         this.var_511.addEventListener(TimerEvent.TIMER,this.onResizeTimer);
         this.var_33.messageHandler.addRoomVisitsListener(this);
         this.var_33.connection.send(new GetRoomVisitsMessageComposer(this._userId));
         this._frame = IFrameWindow(this.var_33.getXmlWindow("roomvisits_frame"));
         this._list = IItemListWindow(this._frame.findChildByName("visits_list"));
         this._frame.procedure = this.onWindow;
         var _loc1_:IWindow = this._frame.findChildByTag("close");
         _loc1_.procedure = this.onClose;
      }
      
      public function onRoomVisits(param1:RoomVisitsData) : void
      {
         if(param1.userId != this._userId)
         {
            return;
         }
         if(this._disposed)
         {
            return;
         }
         this.var_109 = param1.rooms;
         this._frame.caption = "Room visits: " + param1.userName;
         this.populate();
         this.onResizeTimer(null);
         this._frame.visible = true;
         this.var_33.messageHandler.removeRoomVisitsListener(this);
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1675;
      }
      
      public function getId() : String
      {
         return "" + this._userId;
      }
      
      public function getFrame() : IFrameWindow
      {
         return this._frame;
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in this.var_109)
         {
            this.populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:RoomVisitData, param2:Boolean) : void
      {
         var _loc3_:IWindowContainer = this.getRoomRowWindow();
         var _loc4_:uint = !!param2 ? 4288861930 : uint(4294967295);
         _loc3_.color = _loc4_;
         var _loc5_:IWindow = _loc3_.findChildByName("room_name_txt");
         _loc5_.caption = param1.roomName;
         new OpenRoomTool(this._frame,this.var_33,_loc5_,param1.isPublic,param1.roomId);
         _loc5_.color = _loc4_;
         var _loc6_:ITextWindow = ITextWindow(_loc3_.findChildByName("time_txt"));
         _loc6_.text = getFormattedTime(param1.enterHour,param1.enterMinute);
         var _loc7_:ITextWindow = ITextWindow(_loc3_.findChildByName("view_room_txt"));
         new OpenRoomInSpectatorMode(this.var_33,_loc7_,param1.isPublic,param1.roomId);
         _loc7_.color = _loc4_;
         this.addRoomRowToList(_loc3_,this._list);
      }
      
      private function addRoomRowToList(param1:IWindowContainer, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         this.var_1529.push(param1);
      }
      
      private function getRoomRowWindow() : IWindowContainer
      {
         if(false)
         {
            return var_1010.pop() as IWindowContainer;
         }
         return IWindowContainer(this.var_807.clone());
      }
      
      private function storeRoomRowWindow(param1:IWindowContainer) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(var_1010.length < var_1965)
         {
            _loc2_ = param1.findChildByName("room_name_txt");
            _loc2_.procedure = null;
            _loc3_ = param1.findChildByName("view_room_txt");
            _loc3_.procedure = null;
            param1.width = this.var_807.width;
            param1.height = this.var_807.height;
            var_1010.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.dispose();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_41 || param2 != this._frame)
         {
            return;
         }
         if(!this.var_511.running)
         {
            this.var_511.reset();
            this.var_511.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(this._list.parent);
         var _loc3_:IWindow = _loc2_.getChildByName("scroller") as IWindow;
         var _loc4_:* = this._list.scrollableRegion.height > this._list.height;
         if(_loc3_.visible)
         {
            if(!_loc4_)
            {
               _loc3_.visible = false;
               this._list.width += 17;
            }
         }
         else if(_loc4_)
         {
            _loc3_.visible = true;
            this._list.width -= 17;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         if(this._list != null)
         {
            this._list.removeListItems();
            this._list.dispose();
            this._list = null;
         }
         if(this._frame != null)
         {
            this._frame.destroy();
            this._frame = null;
         }
         this.var_33 = null;
         if(this.var_511 != null)
         {
            this.var_511.stop();
            this.var_511.removeEventListener(TimerEvent.TIMER,this.onResizeTimer);
            this.var_511 = null;
         }
         for each(_loc1_ in this.var_1529)
         {
            this.storeRoomRowWindow(_loc1_);
         }
         if(this.var_807 != null)
         {
            this.var_807.dispose();
            this.var_807 = null;
         }
         this.var_1529 = [];
      }
   }
}
