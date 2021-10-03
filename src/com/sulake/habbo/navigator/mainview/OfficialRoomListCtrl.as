package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   
   public class OfficialRoomListCtrl implements IViewCtrl
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_175:IWindowContainer;
      
      private var _list:IItemListWindow;
      
      public function OfficialRoomListCtrl(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function set content(param1:IWindowContainer) : void
      {
         this.var_175 = param1;
         this._list = IItemListWindow(this.var_175.findChildByName("item_list"));
      }
      
      public function get content() : IWindowContainer
      {
         return this.var_175;
      }
      
      public function refresh() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:Array = this.getVisibleEntries();
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
      
      private function getVisibleEntries() : Array
      {
         var _loc4_:* = null;
         var _loc1_:Array = this._navigator.data.officialRooms.entries;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         for each(_loc4_ in _loc1_)
         {
            if(_loc4_.folderId > 0)
            {
               if(_loc4_.folderId == _loc3_)
               {
                  _loc2_.push(_loc4_);
               }
            }
            else
            {
               _loc3_ = !!_loc4_.open ? int(_loc4_.index) : 0;
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:OfficialRoomEntryData) : Boolean
      {
         var _loc4_:IWindowContainer = IWindowContainer(this._list.getListItemAt(param2));
         var _loc5_:Boolean = false;
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = this._navigator.officialRoomEntryManager.createEntry(param2);
            this._list.addListItem(_loc4_);
            _loc5_ = true;
         }
         this._navigator.officialRoomEntryManager.refreshEntry(_loc4_,param1,param2,param3);
         return false;
      }
   }
}
