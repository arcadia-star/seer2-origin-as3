package com.taomee.seer2.app.chat
{
   import com.taomee.seer2.app.chat.constant.ChatPipeType;
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   import com.taomee.seer2.app.chat.panel.ChatPanelPipe;
   import com.taomee.seer2.app.chat.pipe.BubbleChatPipe;
   import com.taomee.seer2.app.chat.pipe.IChatPipe;
   import com.taomee.seer2.app.chat.pipe.TeamChatPipe;
   import com.taomee.seer2.app.team.TeamManager;
   import com.taomee.seer2.app.team.events.TeamEvent;
   import com.taomee.seer2.core.log.Logger;
   import org.taomee.ds.HashMap;
   
   public class ChatManager
   {
      
      private static var _logger:Logger;
      
      private static var _pipeTypeMap:HashMap;
      
      private static var _chatPanelPipe:ChatPanelPipe;
      
      private static var _teamChatPipe:TeamChatPipe;
      
      {
         initialize();
      }
      
      public function ChatManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _pipeTypeMap = new HashMap();
         _logger = Logger.getLogger("ChatManager");
         addPipe(new BubbleChatPipe());
         _chatPanelPipe = new ChatPanelPipe();
         addPipe(_chatPanelPipe);
         initTeamChatPipe();
      }
      
      private static function initTeamChatPipe() : void
      {
         if(TeamManager.teamId > 0)
         {
            _teamChatPipe = new TeamChatPipe();
            addPipe(_teamChatPipe);
            TeamManager.addEventListener(TeamEvent.QUIT,onQuitTeam);
            TeamManager.addEventListener(TeamEvent.DISOLVE,onQuitTeam);
         }
         else
         {
            TeamManager.addEventListener(TeamEvent.ADD,onHasTeam);
            TeamManager.addEventListener(TeamEvent.CREATE,onHasTeam);
         }
      }
      
      private static function onHasTeam(param1:TeamEvent) : void
      {
         TeamManager.removeEventListener(TeamEvent.ADD,onHasTeam);
         TeamManager.removeEventListener(TeamEvent.CREATE,onHasTeam);
         TeamManager.addEventListener(TeamEvent.QUIT,onQuitTeam);
         TeamManager.addEventListener(TeamEvent.DISOLVE,onQuitTeam);
         if(_teamChatPipe == null)
         {
            _teamChatPipe = new TeamChatPipe();
            addPipe(_teamChatPipe);
         }
      }
      
      private static function onQuitTeam(param1:TeamEvent) : void
      {
         TeamManager.addEventListener(TeamEvent.ADD,onHasTeam);
         TeamManager.addEventListener(TeamEvent.CREATE,onHasTeam);
         TeamManager.removeEventListener(TeamEvent.QUIT,onQuitTeam);
         TeamManager.removeEventListener(TeamEvent.DISOLVE,onQuitTeam);
         removePipeType(ChatPipeType.TEAM);
      }
      
      public static function addPipe(param1:IChatPipe) : void
      {
         var _loc2_:Vector.<IChatPipe> = null;
         if(_pipeTypeMap.containsKey(param1.type) == false)
         {
            _loc2_ = new Vector.<IChatPipe>();
            _pipeTypeMap.add(param1.type,_loc2_);
         }
         _loc2_ = _pipeTypeMap.getValue(param1.type) as Vector.<IChatPipe>;
         _loc2_.push(param1);
      }
      
      public static function removePipe(param1:IChatPipe) : void
      {
         var _loc2_:Vector.<IChatPipe> = null;
         if(_pipeTypeMap.containsKey(param1.type))
         {
            _loc2_ = _pipeTypeMap.getValue(param1.type) as Vector.<IChatPipe>;
            removePipeFromVec(_loc2_,param1);
         }
         else
         {
            _logger.error("No pipe of this type exist.");
         }
      }
      
      public static function getTypePipe(param1:int) : Vector.<IChatPipe>
      {
         if(_pipeTypeMap.containsKey(param1))
         {
            return _pipeTypeMap.getValue(param1) as Vector.<IChatPipe>;
         }
         _logger.error("No pipe of this type exist.");
         return null;
      }
      
      public static function removePipeType(param1:int) : void
      {
         if(_pipeTypeMap.containsKey(param1))
         {
            _pipeTypeMap.remove(param1);
         }
         else
         {
            _logger.error("No pipe of this type exist.");
         }
      }
      
      private static function removePipeFromVec(param1:Vector.<IChatPipe>, param2:IChatPipe) : void
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            if(param1[_loc4_] == param2)
            {
               param1.splice(_loc4_,1);
               return;
            }
            _loc4_--;
         }
         _logger.error("Pipe not exist.");
      }
      
      public static function onMessage(param1:ChatReceivedMessage) : void
      {
         var _loc3_:IChatPipe = null;
         _logger.info(param1.pipeType + " " + param1.senderId + " " + param1.senderNick + " " + param1.message);
         var _loc2_:Vector.<IChatPipe> = getTypePipe(param1.pipeType);
         if(_loc2_)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.onMessage(param1);
            }
         }
      }
      
      public static function clearAll() : void
      {
         _pipeTypeMap = new HashMap();
      }
      
      public static function get chatPanelPipe() : ChatPanelPipe
      {
         return _chatPanelPipe;
      }
      
      public static function get teamChatPipe() : TeamChatPipe
      {
         return _teamChatPipe;
      }
   }
}
