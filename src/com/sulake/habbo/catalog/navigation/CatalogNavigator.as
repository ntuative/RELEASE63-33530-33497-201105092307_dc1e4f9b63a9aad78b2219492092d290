package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   import com.sulake.habbo.window.utils.IAlertDialog;
   
   public class CatalogNavigator implements ICatalogNavigator
   {
       
      
      private var _catalog:IHabboCatalog;
      
      private var _container:IWindowContainer;
      
      private var _list:IItemListWindow;
      
      private var _index:ICatalogNode;
      
      private var var_355:Array;
      
      private var _scrollBar:IScrollbarWindow;
      
      private var var_2969:String = "magic.credits";
      
      private var var_2931:String = "magic.pixels";
      
      private var var_2930:String = "catalog.page.club";
      
      public function CatalogNavigator(param1:IHabboCatalog, param2:IWindowContainer)
      {
         super();
         this._catalog = param1;
         this._container = param2;
         this.var_355 = [];
         this._list = this._container.findChildByName("navigationList") as IItemListWindow;
         var _loc3_:IWindow = this._container.findChildByName("creditsContainer");
         var _loc4_:IWindow = this._container.findChildByName("pixelsContainer");
         var _loc5_:IWindow = this._container.findChildByName("clubContainer");
         _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onNavigatorEvent);
         _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onNavigatorEvent);
         _loc3_.addEventListener(WindowMouseEvent.const_25,this.onNavigatorEvent);
         _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onNavigatorEvent);
         _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onNavigatorEvent);
         _loc4_.addEventListener(WindowMouseEvent.const_25,this.onNavigatorEvent);
         _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onNavigatorEvent);
         _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onNavigatorEvent);
         _loc5_.addEventListener(WindowMouseEvent.const_25,this.onNavigatorEvent);
         this._scrollBar = this._container.findChildByName("navigationListScrollbar") as IScrollbarWindow;
         if(this._scrollBar != null)
         {
            this._scrollBar.visible = false;
            this._scrollBar.addEventListener(WindowEvent.const_977,this.activateScrollbar);
            this._scrollBar.addEventListener(WindowEvent.const_254,this.activateScrollbar);
            this._scrollBar.addEventListener(WindowEvent.const_826,this.deActivateScrollbar);
            this._scrollBar.addEventListener(WindowEvent.const_273,this.deActivateScrollbar);
         }
      }
      
      public function dispose() : void
      {
         this._catalog = null;
         this._container = null;
         this._list = null;
         if(this._index)
         {
            this._index.dispose();
         }
         this._index = null;
         this.var_355 = null;
         this._scrollBar = null;
      }
      
      public function buildCatalogIndex(param1:NodeData) : void
      {
         var _loc2_:* = null;
         this._index = null;
         this._index = this.buildIndexNode(param1,0);
         for each(_loc2_ in this._index.children)
         {
            if(_loc2_.isNavigateable)
            {
               (_loc2_ as CatalogNodeRenderable).addToList(this._list);
            }
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return this._catalog;
      }
      
      public function activateNode(param1:ICatalogNode) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = this.var_355.indexOf(param1) > -1;
         var _loc3_:Boolean = param1.isOpen;
         var _loc4_:* = [];
         for each(_loc5_ in this.var_355)
         {
            _loc5_.deActivate();
            if(_loc5_.depth >= param1.depth)
            {
               _loc4_.push(_loc5_);
            }
         }
         for each(_loc6_ in _loc4_)
         {
            _loc6_.close();
            _loc7_ = this.var_355.indexOf(_loc6_);
            this.var_355.splice(_loc7_,1);
         }
         param1.activate();
         if(_loc2_ && _loc3_)
         {
            param1.close();
         }
         else
         {
            param1.open();
         }
         if(this.var_355.indexOf(param1) == -1)
         {
            this.var_355.push(param1);
         }
         this._catalog.loadCatalogPage(param1.pageId,-1);
         this._catalog.events.dispatchEvent(new CatalogPageOpenedEvent(param1.pageId,param1.localization));
      }
      
      public function openPage(param1:String) : void
      {
         var _loc2_:ICatalogNode = this.getNodeByName(param1);
         if(_loc2_ != null)
         {
            this._catalog.loadCatalogPage(_loc2_.pageId,-1);
            this.openNavigatorAtNode(_loc2_);
         }
      }
      
      public function openPageById(param1:int, param2:int) : void
      {
         var _loc3_:ICatalogNode = this.getNodeById(param1,this._index);
         if(_loc3_ != null)
         {
            this._catalog.loadCatalogPage(_loc3_.pageId,param2);
            this.openNavigatorAtNode(_loc3_);
         }
      }
      
      private function openNavigatorAtNode(param1:ICatalogNode) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in this.var_355)
         {
            _loc2_.deActivate();
            _loc2_.close();
         }
         this.var_355 = [];
         _loc3_ = param1.parent;
         while(_loc3_ != null && _loc3_.parent != null)
         {
            _loc3_.open();
            this.var_355.push(_loc3_);
            _loc3_ = _loc3_.parent;
         }
         this.activateNode(param1);
      }
      
      public function openFrontPage() : void
      {
         var _loc1_:ICatalogNode = this.getFirstNavigateable(this._index);
         Logger.log("Load front page: " + _loc1_.localization + "(" + _loc1_.pageId + ")");
         this._catalog.loadCatalogPage(_loc1_.pageId,-1);
      }
      
      private function openCreditsPage() : void
      {
         if(this._catalog)
         {
            this._catalog.openCreditsHabblet();
         }
      }
      
      private function onExternalLink(param1:IAlertDialog, param2:WindowEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.dispose();
      }
      
      private function openPixelsPage() : void
      {
         this.openPage(this.var_2931);
      }
      
      private function openClubPage() : void
      {
         this._catalog.openCatalogPage(this.var_2930,true);
      }
      
      private function getFirstNavigateable(param1:ICatalogNode) : ICatalogNode
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.isNavigateable && param1 != this._index)
         {
            return param1;
         }
         for each(_loc2_ in param1.children)
         {
            _loc3_ = this.getFirstNavigateable(_loc2_);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function buildIndexNode(param1:NodeData, param2:int) : ICatalogNode
      {
         var _loc5_:* = null;
         var _loc3_:Boolean = param1.navigateable;
         var _loc4_:* = null;
         if(!_loc3_)
         {
            _loc4_ = new CatalogNode(this,param1,param2) as ICatalogNode;
         }
         else
         {
            _loc4_ = new CatalogNodeRenderable(this,param1,param2) as ICatalogNode;
         }
         if(_loc4_ == null)
         {
            Logger.log("Catalog index node creation failed!");
            return null;
         }
         param2++;
         for each(_loc5_ in param1.nodes)
         {
            _loc4_.addChild(this.buildIndexNode(_loc5_,param2));
         }
         return _loc4_;
      }
      
      private function getNodeByName(param1:String) : ICatalogNode
      {
         return this.getFirstNodeByName(param1,this._index);
      }
      
      private function getNodeById(param1:int, param2:ICatalogNode) : ICatalogNode
      {
         var currentPageId:int = 0;
         var child:ICatalogNode = null;
         var pageId:int = param1;
         var node:ICatalogNode = param2;
         var found:ICatalogNode = null;
         try
         {
            currentPageId = node.pageId;
            if(currentPageId == pageId && node != this._index)
            {
               found = node;
            }
            else
            {
               for each(child in node.children)
               {
                  found = this.getNodeById(pageId,child);
                  if(found != null)
                  {
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            Logger.log("error when loading node by id " + pageId + ":",e);
         }
         return found;
      }
      
      private function getFirstNodeByName(param1:String, param2:ICatalogNode) : ICatalogNode
      {
         var child:ICatalogNode = null;
         var localizedName:String = param1;
         var node:ICatalogNode = param2;
         var found:ICatalogNode = null;
         try
         {
            if(node.localization == localizedName && node != this._index)
            {
               found = node;
            }
            else
            {
               for each(child in node.children)
               {
                  found = this.getFirstNodeByName(localizedName,child);
                  if(found != null)
                  {
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            Logger.log("error when loading node by name " + localizedName + ":",e);
         }
         return found;
      }
      
      private function onNavigatorEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(param1.target);
         var _loc3_:String = IWindow(param1.target).name;
         switch(param1.type)
         {
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
               _loc2_.getChildByName("background").color = 4281692560;
               break;
            case WindowMouseEvent.const_25:
               _loc2_.getChildByName("background").color = 4280767850;
               break;
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
               switch(_loc3_)
               {
                  case "creditsContainer":
                     this.openCreditsPage();
                     break;
                  case "pixelsContainer":
                     this.openPixelsPage();
                     break;
                  case "clubContainer":
                     this.openClubPage();
               }
         }
      }
      
      private function activateScrollbar(param1:WindowEvent) : void
      {
         (param1.target as IWindow).visible = true;
      }
      
      private function deActivateScrollbar(param1:WindowEvent) : void
      {
         (param1.target as IWindow).visible = false;
      }
   }
}
