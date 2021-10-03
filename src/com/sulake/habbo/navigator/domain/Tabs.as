package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;
   
   public class Tabs
   {
      
      public static const const_397:int = 1;
      
      public static const const_242:int = 2;
      
      public static const const_359:int = 3;
      
      public static const const_435:int = 4;
      
      public static const const_271:int = 5;
      
      public static const const_437:int = 1;
      
      public static const const_831:int = 2;
      
      public static const const_843:int = 3;
      
      public static const const_942:int = 4;
      
      public static const const_251:int = 5;
      
      public static const const_853:int = 6;
      
      public static const const_915:int = 7;
      
      public static const const_291:int = 8;
      
      public static const const_447:int = 9;
      
      public static const const_2069:int = 10;
      
      public static const const_868:int = 11;
      
      public static const const_541:int = 12;
       
      
      private var var_450:Array;
      
      private var _navigator:HabboNavigator;
      
      public function Tabs(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
         this.var_450 = new Array();
         this.var_450.push(new Tab(this._navigator,const_397,const_541,new EventsTabPageDecorator(this._navigator),MainViewCtrl.const_501));
         this.var_450.push(new Tab(this._navigator,const_242,const_437,new RoomsTabPageDecorator(this._navigator),MainViewCtrl.const_501));
         this.var_450.push(new Tab(this._navigator,const_435,const_868,new OfficialTabPageDecorator(this._navigator),MainViewCtrl.const_1202));
         this.var_450.push(new Tab(this._navigator,const_359,const_251,new MyRoomsTabPageDecorator(this._navigator),MainViewCtrl.const_501));
         this.var_450.push(new Tab(this._navigator,const_271,const_291,new SearchTabPageDecorator(this._navigator),MainViewCtrl.const_956));
         this.setSelectedTab(const_397);
      }
      
      public function onFrontPage() : Boolean
      {
         return this.getSelected().id == const_435;
      }
      
      public function get tabs() : Array
      {
         return this.var_450;
      }
      
      public function setSelectedTab(param1:int) : void
      {
         this.clearSelected();
         this.getTab(param1).selected = true;
      }
      
      public function getSelected() : Tab
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_450)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function clearSelected() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_450)
         {
            _loc1_.selected = false;
         }
      }
      
      public function getTab(param1:int) : Tab
      {
         var _loc2_:* = null;
         for each(_loc2_ in this.var_450)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
