//
//  CONSTS.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#ifndef CONSTS_h
#define CONSTS_h
//..................    主题颜色

#define DEDAULT_COLOR    [UIColor colorWithRed:(105)/255.0f green:(149)/255.0f blue:(246)/255.0f alpha:(1)]

#define  APP_Del     (AppDelegate *)[UIApplication sharedApplication].delegate
#define  DATA_EN     [SingTonManger sharedSingTonManger]

#define RefreshDataFinshedNotification @"RefreshDataFinshedNotification"
#define EndRefresh [[NSNotificationCenter defaultCenter]postNotificationName:RefreshDataFinshedNotification object:self.view]

typedef enum{
   TVTypeUnknown,
   TVTypeQuanmin,
   TVTypedouyu,
   TVTypezhanqi
}TVType;


//..................    全民TV api
//推荐url
#define RecommendUrl      @"http://www.quanmin.tv/json/page/appv2-index/info.json?0330152228"
//栏目url
#define ColumnUrl          @"http://www.quanmin.tv/json/categories/list.json?0330152804"
//
//直播url
#define DirectSeedingUrl   @"http://www.quanmin.tv/json/play/list.json?0330152923"



//...................    斗鱼TV api
//推荐
#define DouyuRecommentUrl  @"http://www.douyutv.com/api/v1/slide/6"
//列表
#define DouyuLolListUrl     @"http://open.douyucdn.cn/api/RoomApi/live/lol"


//..................    战旗 TV api
//首页
#define ZhanqiRecommentUrl  @"http://www.zhanqi.tv/api/static/live.index/recommend-apps.json"
//推荐
#define ZhanqiPagedataUrl   @"http://www.zhanqi.tv/api/touch/apps.banner?rand=1455848328344"
//lol
#define ZhanqiLolListUrl    @"http://www.zhanqi.tv/api/static/game.lives/6/20-1.json"

//.....................  lol资讯 api

/**
 *
 *  =Union_News=
 *
 *  Interface
 *
 **/
//消息列表
#define kNews_ListURL          @"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=%@&p=%@"

#define News_PrettyPicturesURL @"http://box.dwstatic.com/apiAlbum.php?action=l&albumsTag=%@&p=%@"

#define News_TopicURL          @"http://box.dwstatic.com/apiNewsList.php?action=topic&topicId=%@"

#define News_LPLLiveURL        @"http://lol.duowan.com/1501/m_285071449546.html"

#define News_LPLItegralURL     @"http://lol.duowan.com/1501/m_285071469977.html"

#define News_WebViewURl        @"http://box.dwstatic.com/apiNewsList.php?action=d&newsId="

#define News_PicturesURL       @"http://box.dwstatic.com/apiAlbum.php?action=d&albumId="

/**
 *
 *  =Union_News=
 *
 *  Interface
 *
 *  ===END===
 **/




/**
 *
 *  =Union_Video=
 *
 *  Interface
 *
 **/



//分类视图URL

#define kUnion_Video_SortURL @"http://box.dwstatic.com/apiVideoesNormalDuowan.php?src=duowan&action=c&sk=&sn=&pn="

//最新视图URL

#define kUnion_Video_NewURL @"http://box.dwstatic.com/apiVideoesNormalDuowan.php?src=duowan&action=l&sk=&pageUrl=&heroEnName=&tag=newest&p=%ld"

//分类中点击cell后URL

#define kUnion_Video_URL @"http://box.dwstatic.com/apiVideoesNormalDuowan.php?v=117&action=l&p=%@&tag=%@&src=letv"

//视频搜索URL

#define kUnion_Video_SearchURL @"http://box.dwstatic.com/apiVideoesNormalDuowan.php?searchKey=%@&p=%@&v=118&action=search"

//视频详情URL

#define kUnion_VideoDetailsURL @"http://box.dwstatic.com/apiVideoesNormalDuowan.php?action=f&vid=%@"


/**
 *
 *  =Union_Video=
 *
 *  Interface
 *
 *  ===END===
 **/


/**
 *
 *  =Union_Ency=
 *
 *  Interface
 *
 **/

//联盟百科菜单URL

#define kUnion_EncyMenuURL @"http://box.dwstatic.com/apiToolMenu.php?category=database&v=117&OSType=iOS8.4&versionName=2.2.7"

//英雄列表URL

#define kUnion_Ency_HeroListURL @"http://lolbox.duowan.com/phone/apiHeroes.php?type=%@"

//我的英雄列表URL

#define kUnion_Ency_MyHeroListURL @"http://lolbox.duowan.com/phone/apiMyHeroes.php?serverName=%@&target=%@&v=108"

//英雄详情URL

#define kUnion_Ency_HeroDetailsURL @"http://lolbox.duowan.com/phone/apiHeroDetail.php?heroName=%@"


//英雄 —— 英雄图片 (PNG)

//http://img.lolbox.duowan.com/champions/英雄名_120x120.jpg

#define kUnion_Ency_HeroImageURL @"http://img.lolbox.duowan.com/champions/%@_120x120.jpg"

//英雄 —— 英雄技能图片 (PNG)

//http://img.lolbox.duowan.com/abilities/Yasuo_E_64x64.png

#define KUnion_Ency_HeroSkillImageURL @"http://img.lolbox.duowan.com/abilities/%@_64x64.png"

//英雄详情-英雄出装列表URL

#define kUnion_Ency_HeroDetails_EquipSelectURL @"http://db.duowan.com/lolcz/img/ku11/api/lolcz.php?v=108&OSType=iOS8.3&championName=%@&limit=7"

//英雄详情-英雄排行TOP10URL

#define kUnion_Ency_HeroDetails_RankingURL @"http://lolbox.duowan.com/phone/heroTop10PlayersNew.php?hero=%@"

//英雄详情-英雄皮肤URL

#define kUnion_Ency_HeroDetails_PiFuURL @"http://box.dwstatic.com/apiHeroSkin.php?hero=%@"


//英雄详情-英雄配音URL

#define kUnion_Ency_HeroDetails_MusicURL @"http://box.dwstatic.com/sounds/%@/%@.mp3"





//装备分类列表URL

#define kUnion_Equip_Type_ListURL @"http://lolbox.duowan.com/phone/apiZBCategory.php"

//装备列表URL

#define kUnion_Equip_ListURl @"http://lolbox.duowan.com/phone/apiZBItemList.php?tag=%@"

//装备图片URL

#define kUnion_Equip_ListImageURL @"http://img.lolbox.duowan.com/zb/%ld_64x64.png"

//装备详情URL

#define kUnion_Equip_DetailsURL @"http://lolbox.duowan.com/phone/apiItemDetail.php?id=%ld"



//符文URL

#define kUnion_AllRunesURL @"http://lolbox.duowan.com/phone/apiRunes.php"

//符文图片URL

//http://img.lolbox.duowan.com/runes/bl_2_3.png

//http://img.lolbox.duowan.com/runes/Img_等级.png

#define kUnion_RunesImageURL @"http://img.lolbox.duowan.com/runes/%@_%ld.png"








/**
 *
 *  =Union_Ency=
 *
 *  Interface
 *
 *  ===END===
 **/





/**
 *
 *  =Union_MyUnion=
 *
 *  Interface
 *
 **/

//全部服务器URL

#define kAllServersURL @"http://lolbox.duowan.com/phone/apiServers.php";


//添加召唤师URL

#define kUnion_MyUion_AddSummonerURL @"http://lolbox.duowan.com/phone/apiCheckUser.php?action=getPlayersInfo&serverName=%@&target=%@"

//我的信息URL

#define kUnion_MyUnion_URL @"http://zdl.mbox.duowan.com/phone/playerDetailNew.php?sn=%@&target=%@&v=108&OSType=iOS8.4&versionName=2.2.5"

//召唤师头像URL

#define kUnion_MyUnion_IconURL @"http://img.lolbox.duowan.com/profileIcon/profileIcon%@.jpg"

/**
 *
 *  =Union_MyUnion=
 *
 *  Interface
 *
 *  ===END===
 **/





#endif /* CONSTS_h */
