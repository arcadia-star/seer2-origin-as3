package com.taomee.seer2.module.login.util
{
   import flash.utils.Dictionary;
   
   public class ErrorCodeMap
   {
      
      private static var _map:Dictionary;
      
      {
         initialize();
      }
      
      public function ErrorCodeMap()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _map = new Dictionary();
         _map[1] = "密码出错太多\n";
         _map[2] = "验证码输入错误\n";
         _map[3] = "帐号错误\n";
         _map[4] = "米米号被封停\n";
         _map[5] = "系统出错\n";
         _map[97] = "Session已经失效\n";
         _map[104333] = "用户永久被禁";
         _map[104334] = "用户被禁24小时";
         _map[104335] = "用户被禁一周";
         _map[104336] = "用户被禁两周";
         _map[104383] = "用户被禁30天";
         _map[5001] = "该账号未完成身份证实名认证或为未成年人账号受防沉迷限制，请前往account.61.com或kf.61.com查询！";
         _map[5002] = "\n米米号被封停";
         _map[5003] = "\n帐号或密码错误";
         _map[5004] = "\n帐号错误";
         _map[5005] = "\n帐号错误";
         _map[5009] = "\n密码输错次数太多";
         _map[6001] = "\n用户不存在";
         _map[6006] = "\n用户昵称不合法";
         _map[6007] = "\n用户游戏角色已创建";
         _map[6008] = "\n协议长度不正确";
         _map[6011] = "\n角色不存在";
         _map[6012] = "\n角色已存在";
         _map[6013] = "\n角色数量已达到上限";
         _map[6014] = "\n昵称不合法";
         _map[6101] = "\n激活码不存在";
         _map[6102] = "\n激活码已使用过";
         _map[6103] = "\n用户还没激活";
      }
      
      public static function getInfoByCode(param1:int) : String
      {
         if(_map.hasOwnProperty(param1))
         {
            return _map[param1];
         }
         return "系统错误";
      }
   }
}
