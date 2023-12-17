package com.taomee.seer2.core.net.message
{
   import com.taomee.seer2.core.net.MessageEvent;
   
   public interface IMessageHandler
   {
       
      
      function setup() : void;
      
      function onMessage(param1:MessageEvent) : void;
      
      function dispose() : void;
   }
}
