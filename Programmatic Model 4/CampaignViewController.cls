public with sharing class CampaignViewController {
    private String baseQuery1 = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign ORDER BY LastModifiedDate DESC';
    private String baseQuery2 = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign ORDER BY StartDate DESC';
    private String baseQuery3 = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign WHERE isActive=true ORDER BY StartDate DESC';
    private String baseQuery4 = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign WHERE isActive=false ORDER BY StartDate DESC';
    Map<String,String> mapListView = new Map<String,String>();
    public String campaignFilterId {get; set;}
    private Integer pageSize = 20;
    public CampaignViewController(){}
      public ApexPages.StandardSetController AccSetController {
            get{
                if(AccSetController == null){
                    AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery1));
                    AccSetController.setPageSize(pageSize);
                    if(campaignFilterId != null){
                       AccSetController.setFilterId(campaignFilterId);
                    }
                }
                 return AccSetController;
            }set;
      }
      
      public CampaignViewController(ApexPages.StandardSetController c) {}
        public void next(){
          if(AccSetController.getHasNext()){
              AccSetController.next();
          }
        }
        public void prev(){
           if(AccSetController.getHasPrevious()){
               AccSetController.previous();
           }
        }
        public List<Campaign> getCampaigns(){
            return (List<Campaign>)AccSetController.getRecords();
        }
        public SelectOption[] getCampaignExistingViews(){
           return AccSetController.getListViewOptions();
        }
        public pageReference resetFilter(){
            for(System.SelectOption s: AccSetController.getListViewOptions()){
                        mapListView.put(s.getLabel(),s.getValue());
            }
            if(mapListView.get('Recently Modified')==campaignFilterId){
                System.debug('Inside recent If');
                AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery1));
                    }else if(mapListView.get('All Campaigns')==campaignFilterId){
                        System.debug('Inside OTHERS else');
                        AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery2));
                    }else if(mapListView.get('All Active Campaigns')==campaignFilterId){
                        AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery3));
                    }else if(mapListView.get('InActive Campaign')==campaignFilterId){
                        AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery4));
                    }
            AccSetController.setPageNumber(1);
            return null;
        }
}