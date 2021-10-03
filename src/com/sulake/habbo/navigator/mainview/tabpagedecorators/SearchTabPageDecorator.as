package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.TextSearchInputs;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   
   public class SearchTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1665:TextSearchInputs;
      
      public function SearchTabPageDecorator(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc4_:* = null;
         if(this.var_1665 == null)
         {
            _loc4_ = param1.getChildByName("search_header") as IWindowContainer;
            this.var_1665 = new TextSearchInputs(this._navigator,false,_loc4_);
            this.initClearResults(_loc4_);
         }
         var _loc3_:IWindowContainer = param1.getChildByName("search_header") as IWindowContainer;
         if(this._navigator.data.guestRoomSearchArrived && this._navigator.data.guestRoomSearchResults.searchType == Tabs.const_291)
         {
            this.var_1665.searchStr.setText(this._navigator.data.guestRoomSearchResults.searchParam);
         }
         this.refreshSearchInfo(_loc3_);
         _loc3_.visible = true;
      }
      
      public function tabSelected() : void
      {
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         this._navigator.mainViewCtrl.open();
      }
      
      private function refreshSearchInfo(param1:IWindowContainer) : void
      {
         var _loc2_:ITextWindow = param1.findChildByName("tag_search_info") as ITextWindow;
         var _loc3_:ITextWindow = param1.findChildByName("text_search_info") as ITextWindow;
         var _loc4_:ITextWindow = param1.findChildByName("tag_search_results") as ITextWindow;
         var _loc5_:ITextWindow = param1.findChildByName("clear_results") as ITextWindow;
         _loc2_.visible = false;
         _loc3_.visible = false;
         _loc4_.visible = false;
         _loc5_.visible = false;
         if(this._navigator.data.popularTagsArrived)
         {
            _loc2_.visible = true;
         }
         else if(this._navigator.data.guestRoomSearchArrived)
         {
            _loc5_.visible = true;
            if(this._navigator.data.guestRoomSearchResults.searchType == Tabs.const_447)
            {
               this._navigator.registerParameter("navigator.tagsearchresults","room_count","" + this._navigator.data.guestRoomSearchResults.rooms.length);
               this._navigator.registerParameter("navigator.tagsearchresults","tag_name",this.padCommas(this._navigator.data.guestRoomSearchResults.searchParam));
               _loc4_.visible = true;
            }
            else
            {
               this._navigator.registerParameter("navigator.textsearchresults","room_count","" + this._navigator.data.guestRoomSearchResults.rooms.length);
               this._navigator.registerParameter("navigator.textsearchresults","search_str","" + this._navigator.data.guestRoomSearchResults.searchParam);
               _loc3_.visible = this._navigator.data.guestRoomSearchArrived;
            }
         }
      }
      
      private function initClearResults(param1:IWindowContainer) : void
      {
         Util.setProc(param1,"clear_results",this.onClearResultsClick);
      }
      
      private function onClearResultsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this._navigator.mainViewCtrl.startSearch(Tabs.const_271,Tabs.const_291,"-1",MainViewCtrl.const_956);
      }
      
      private function padCommas(param1:String) : String
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:String = _loc2_[0];
         var _loc4_:int = 1;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ += ", " + _loc2_[_loc4_];
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
