package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.enum.WindowParam;
   import flash.geom.Rectangle;
   
   public class HeaderController extends ContainerController implements IHeaderWindow
   {
      
      private static const const_1520:String = "_TITLE";
      
      private static const const_1521:String = "_CONTROLS";
       
      
      public function HeaderController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 0;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get title() : ILabelWindow
      {
         return findChildByTag(const_1520) as ILabelWindow;
      }
      
      public function get controls() : IItemListWindow
      {
         return findChildByTag(const_1521) as IItemListWindow;
      }
      
      override public function set caption(param1:String) : void
      {
         var value:String = param1;
         super.caption = value;
         try
         {
            this.title.text = value;
         }
         catch(e:Error)
         {
            Logger.log("Header contains no title element!");
         }
      }
      
      override public function set color(param1:uint) : void
      {
         var _loc3_:* = null;
         super.color = param1;
         var _loc2_:Array = new Array();
         groupChildrenWithTag(const_1332,_loc2_,true);
         for each(_loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
   }
}
