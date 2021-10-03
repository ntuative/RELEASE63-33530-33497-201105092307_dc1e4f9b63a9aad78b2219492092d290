package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.MouseCursorType;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   
   public class MouseCursorControl
   {
      
      private static var _type:uint = MouseCursorType.const_30;
      
      private static var var_135:Stage;
      
      private static var var_294:Boolean = true;
      
      private static var _disposed:Boolean = false;
      
      private static var var_732:Boolean = true;
      
      private static var var_111:DisplayObject;
      
      private static var var_1384:Dictionary = new Dictionary();
       
      
      public function MouseCursorControl(param1:DisplayObject)
      {
         super();
         var_135 = param1.stage;
      }
      
      public static function dispose() : void
      {
         if(!_disposed)
         {
            if(var_111)
            {
               var_135.removeChild(var_111);
               var_135.removeEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
               var_135.removeEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
               var_135.removeEventListener(MouseEvent.MOUSE_OVER,onStageMouseMove);
               var_135.removeEventListener(MouseEvent.MOUSE_OUT,onStageMouseMove);
            }
            _disposed = true;
         }
      }
      
      public static function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public static function get type() : uint
      {
         return _type;
      }
      
      public static function set type(param1:uint) : void
      {
         if(_type != param1)
         {
            _type = param1;
            var_732 = true;
         }
      }
      
      public static function get visible() : Boolean
      {
         return var_294;
      }
      
      public static function set visible(param1:Boolean) : void
      {
         var_294 = param1;
         if(var_294)
         {
            if(var_111)
            {
               var_111.visible = true;
            }
            else
            {
               Mouse.show();
            }
         }
         else if(var_111)
         {
            var_111.visible = false;
         }
         else
         {
            Mouse.hide();
         }
      }
      
      public static function change() : void
      {
         var _loc1_:* = null;
         if(var_732)
         {
            _loc1_ = var_1384[_type];
            if(_loc1_)
            {
               if(var_111)
               {
                  var_135.removeChild(var_111);
               }
               else
               {
                  var_135.addEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
                  var_135.addEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
                  var_135.addEventListener(MouseEvent.MOUSE_OVER,onStageMouseMove);
                  var_135.addEventListener(MouseEvent.MOUSE_OUT,onStageMouseMove);
                  Mouse.hide();
               }
               var_111 = _loc1_;
               var_135.addChild(var_111);
            }
            else
            {
               if(var_111)
               {
                  var_135.removeChild(var_111);
                  var_135.removeEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
                  var_135.removeEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
                  var_135.removeEventListener(MouseEvent.MOUSE_OVER,onStageMouseMove);
                  var_135.removeEventListener(MouseEvent.MOUSE_OUT,onStageMouseMove);
                  var_111 = null;
                  Mouse.show();
               }
               switch(_type)
               {
                  case MouseCursorType.const_30:
                  case MouseCursorType.ARROW:
                     Mouse.cursor = MouseCursor.ARROW;
                     break;
                  case MouseCursorType.const_330:
                     Mouse.cursor = MouseCursor.BUTTON;
                     break;
                  case MouseCursorType.const_747:
                  case MouseCursorType.const_282:
                  case MouseCursorType.const_1620:
                  case MouseCursorType.const_1865:
                     Mouse.cursor = MouseCursor.HAND;
                     break;
                  case MouseCursorType.NONE:
                     Mouse.cursor = MouseCursor.ARROW;
                     Mouse.hide();
               }
            }
            var_732 = false;
         }
      }
      
      public static function defineCustomCursorType(param1:uint, param2:DisplayObject) : void
      {
         var_1384[param1] = param2;
      }
      
      private static function onStageMouseMove(param1:MouseEvent) : void
      {
         if(var_111)
         {
            var_111.x = param1.stageX - 2;
            var_111.y = param1.stageY;
            if(_type == MouseCursorType.const_30)
            {
               var_294 = false;
               Mouse.show();
            }
            else
            {
               var_294 = true;
               Mouse.hide();
            }
         }
      }
      
      private static function onStageMouseLeave(param1:Event) : void
      {
         if(var_111 && _type != MouseCursorType.const_30)
         {
            Mouse.hide();
            var_294 = false;
         }
      }
   }
}
