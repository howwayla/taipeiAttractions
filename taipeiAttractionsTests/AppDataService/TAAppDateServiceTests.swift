//
//  TAAppDateServiceTests.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/28.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import XCTest
import Nimble

class TAAppDateServiceTests: XCTestCase {
    
    let attraction1 = ["_id":"1",
                "RowNumber":"1",
                "REF_WP":"10",
                "CAT1":"景點",
                "CAT2":"養生溫泉",
                "SERIAL_NO":"2011051800000061",
                "MEMO_TIME":"各業者不同，依據現場公告",
                "stitle":"新北投溫泉區",
                "xbody":"北投溫泉從日據時代便有盛名，深受喜愛泡湯的日人自然不會錯過，瀧乃湯、星乃湯、鐵乃湯就是日本人依照溫泉的特性與療效給予的名稱，據說對皮膚病、神經過敏、氣喘、風濕等具有很好的療效，也因此成為了北部最著名的泡湯景點之一。新北投溫泉的泉源為大磺嘴溫泉，泉質屬硫酸鹽泉，PH值約為3~4之間，水質呈黃白色半透明，泉水溫度約為50-90℃，帶有些許的硫磺味 。目前北投的溫泉旅館、飯店、會館大部分集中於中山路、光明路沿線以及北投公園地熱谷附近，總計約有44家，每一家都各有其特色，多樣的溫泉水療以及遊憩設施，提供遊客泡湯養生，而鄰近的景點也是非常值得造訪，例如被列為三級古蹟的三寶吟松閣、星乃湯、瀧乃湯以及北投第一家溫泉旅館「天狗庵」，都有著深遠的歷史背景，而北投公園、北投溫泉博物館、北投文物館、地熱谷等，更是遊客必遊的景點，來到北投除了可以讓溫泉洗滌身心疲憊，也可以順便了解到北投溫泉豐富的人文歷史。",
                "avBegin":"2010/02/14",
                "avEnd":"2015/12/11",
                "idpt":"臺北旅遊網",
                "address":"臺北市 北投區中山路、光明路沿線",
                "xpostDate":"2015/12/11",
                "file":"http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000848.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11002891.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D315/E70/F65/1e0951fb-069f-4b13-b5ca-2d09df1d3d90.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D260/E538/F274/e7d482ba-e3c0-40c3-87ef-3f2a1c93edfa.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D919/E767/F581/9ddde70e-55c2-4cf0-bd3d-7a8450582e55.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D28/E891/F188/77a58890-7711-4ca2-aebe-4aa379726575.JPG",
                "langinfo":"10",
                "POI":"Y",
                "info":"新北投站下車，沿中山路直走即可到達公車：216、218、223、230、266、602、小6、小7、小9、、小22、小25、小26至新北投站下車",
                "longitude":"121.503",
                "latitude":"25.1364",
                "MRT":"新北投"]
    
    let attraction2 = ["_id":"2",
                 "RowNumber":"2",
                 "REF_WP":"10",
                 "CAT1":"景點",
                 "CAT2":"藍色公路",
                 "SERIAL_NO":"2011051800000007",
                 "MEMO_TIME":"平常日以團體預約包船為主，例假日行駛固定航次，請洽詢各船公司。\n強烈季風、漲退潮水位差影響航行及靠泊安全，當日實際航班得由現場公告或網站預告調整。",
                 "stitle":"大稻埕碼頭",
                 "xbody":"大稻埕原是平埔族的居住地，因萬華（艋舺）同安人發生激烈的械鬥，造成族人移至大稻埕定居，開始大稻埕淡水河旁商店和房屋的興建，淡水港開放後，大稻埕在劉銘傳的治理下成為臺北城最繁華的物資集散中心，當中以茶葉、布料為主要貿易交易，當時的延平北路及貴德街一帶便是商業活動的重心，也讓大稻埕早年的歷史多采多姿、令人回味。 ",
                 "avBegin":"2008/08/02",
                 "avEnd":"2015/12/09",
                 "idpt":"臺北旅遊網",
                 "address":"臺北市 大同區環河北路一段",
                 "xpostDate":"2015/12/09",
                 "file":"http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000340.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D906/E6/F186/809f30db-7079-421f-a625-7baa8ec21874.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000341.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D878/E420/F173/04765739-d40f-4d13-b271-8d5f9e5f44bd.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000342.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D20/E983/F199/866b5059-8fd7-4719-964c-51d2f78675d5.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D546/E538/F353/ed2464d1-bc28-4790-96cd-5216db2c14f5.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D814/E111/F733/aed9d34d-890c-49fd-83ca-f76f38e4b94b.jpghttp://www.travel.taipei/streams/sceneadmin/video/100C1.mp3",
                 "langinfo":"10",
                 "POI":"Y",
                 "info":"捷運站名：雙連站，轉乘紅33(固定班次)於大稻埕碼頭站下車。公車：9、206、274、641、669、704至大稻埕碼頭站及255、518、539至民生西路口站，再沿民生西路底方向步行約10分鐘抵達。 開車：沿著環河北路依大稻埕碼頭入口指引便可抵達。",
                 "longitude":"121.508274",
                 "latitude":"25.056847",
                 "MRT":"雙連"]
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAppDataServiceCategoriesTest() {
        
        let attraction1 = TAAttraction(JSON: self.attraction1)
        let attraction2 = TAAttraction(JSON: self.attraction2)
        
        
        TAAppDataService.sharedInstance.attractions = [attraction1, attraction1, attraction2, attraction2]
        expect(TAAppDataService.sharedInstance.categories.count).to(equal(2))
        expect(TAAppDataService.sharedInstance.categories.contains("養生溫泉")).to(beTrue())
        expect(TAAppDataService.sharedInstance.categories.contains("藍色公路")).to(beTrue())
    }
}
