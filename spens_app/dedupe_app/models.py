from django.db import models
from django.utils.timezone import now

class lib_dataset_status(models.Model):
    dataset_status_id = models.AutoField(primary_key=True)
    dataset_status = models.CharField(max_length=100)
    class Meta:
        db_table = 'lib_dataset_status' 
    

class datasets(models.Model):
    dataset_id = models.AutoField(primary_key=True)
    dataset_uid = models.CharField(max_length=36)
    description = models.CharField(max_length=200, blank=True, null=True)
    time_added = models.DateTimeField(null=True)
    user_id = models.IntegerField(null=True, default=1)  # end-user
    row_count = models.IntegerField(null=True, default=0)
    from_roster = models.IntegerField(null=True, default=0)
    
    # dataset_status_id
    # 0 - Normal 
    # 1 - Deleted 
    # 2 - Locked 
    # 6 - Invalid  
    # dataset_status_id = models.IntegerField(null=False, default=0)
    dataset_status_id = models.ForeignKey(lib_dataset_status, on_delete=models.PROTECT, db_column='dataset_status_id')

    def __str__(self):
        return self.dataset_uid

    class Meta:
        db_table = 'tbl_datasets' 


class lib_classification(models.Model):
    classification_id = models.AutoField(primary_key=True)
    classification = models.CharField(max_length=36, null=True)
    class Meta:
        db_table = 'lib_classification' 

class lib_trans_status(models.Model):
    status_id = models.AutoField(primary_key=True)
    status = models.CharField(max_length=200, blank=True, null=True)
    class Meta:
        db_table = 'lib_trans_status' 

class transactions(models.Model):
    trans_id = models.AutoField(primary_key=True)
    dataset_id = models.ForeignKey(datasets, on_delete=models.PROTECT, db_column='dataset_id')  # ForeignKey field
    description = models.CharField(max_length=200, blank=True, null=True)
    progress = models.FloatField(null=True, default=0)

    # status:
    # 0 Pending; 
    # 1 On-Progress
    # 2 Finished
    # 3 Stale
    # 4 Cancelled
    # 5 Paused
    # 6 Invalid dataset
    # status_id = models.IntegerField(null=False, default=0) 
    status_id = models.ForeignKey(lib_trans_status, on_delete=models.PROTECT, db_column='status_id') 

    time_added = models.DateTimeField(null=True)
    checkpoint_time = models.DateTimeField(null=True)
    checkpoint_entry = models.IntegerField(null=True, default=0)
    process_id = models.CharField(max_length=36, null=True)

    # classification_id = models.IntegerField(null=True, default=0)
    classification_id = models.ForeignKey(lib_classification, on_delete=models.PROTECT, db_column='classification_id') 
    
    threshold = models.IntegerField(null=True, default=90)
    limit = models.IntegerField(null=True, default=5)
    scoring_method = models.CharField(max_length=15, blank=True, null=True)
    user_id = models.IntegerField(null=True, default=1)
    row_count = models.IntegerField(null=True, default=0)
    task_type = models.IntegerField(null=True, default=0)
    
    is_deleted = models.IntegerField(null=True, default=0)
    date_deleted = models.DateTimeField(null=True)
    deleted_by = models.IntegerField(null=True, default=0)

    def __str__(self):
        return f"Transaction {self.trans_id}: {self.description or 'No Description'}"
    class Meta:
        db_table = 'tbl_transactions' 

class roster(models.Model):
    HH_ID = models.CharField(max_length=40)
    HH_SET = models.CharField(max_length=10)
    CLIENT_STATUS = models.CharField(max_length=100)
    # ENTRY_ID = models.CharField(max_length=10,primary_key=True,null=False, default='')
    ENTRY_ID = models.CharField(max_length=10, primary_key=True, null=False)
    FIRST_NAME = models.CharField(max_length=100)
    MIDDLE_NAME = models.CharField(max_length=100, null=True, blank=True)
    LAST_NAME = models.CharField(max_length=100, null=True)
    EXT_NAME = models.CharField(max_length=10, null=True, blank=True)
    GRANTEE = models.CharField(max_length=10)
    RELATION_TO_HH_HEAD = models.CharField(max_length=100)
    SEX = models.CharField(max_length=10)
    BIRTHDAY = models.CharField(max_length=100)
    AGE = models.IntegerField()
    MEMBER_STATUS = models.CharField(max_length=100)
    DISABILITY_REMARKS = models.TextField(null=True, blank=True)
    IP_AFFILIATION = models.CharField(max_length=100, null=True, blank=True)
    REGION = models.CharField(max_length=100)
    PROVINCE = models.CharField(max_length=100)
    MUNICIPALITY = models.CharField(max_length=100)
    BARANGAY = models.CharField(max_length=100)
    PROG = models.CharField(max_length=100)
    PREGNANCY_STATUS = models.CharField(max_length=255, null=True, blank=True)
    AGE_ON_HEALTH = models.IntegerField(null=True, blank=True)  # Fixed
    AGE_ON_EDUC = models.IntegerField(null=True, blank=True)  # Fixed
    OCCUPATION = models.CharField(max_length=255, null=True, blank=True)
    ATTEND_SCHOOL = models.CharField(max_length=255, null=True, blank=True)
    SCHOOL_NAME = models.CharField(max_length=255, null=True, blank=True)
    GRADE_LEVEL = models.CharField(max_length=255, null=True, blank=True)
    LRN = models.FloatField(null=True, blank=True)  # Fixed
    MONITORED_EDUC = models.CharField(max_length=255, null=True, blank=True)
    REASON_FOR_NOT_ATTENDING_EDUC = models.CharField(max_length=255, null=True, blank=True)
    HEALTH_FACILITY = models.CharField(max_length=255, null=True, blank=True)
    MONITORED_HEALTH = models.CharField(max_length=255, null=True, blank=True)
    REASON_FOR_NOT_ATTENDING_HEALTH = models.CharField(max_length=255, null=True, blank=True)
    DISABILITY = models.CharField(max_length=255, null=True, blank=True)
    SOLO_PARENT = models.CharField(max_length=255, null=True, blank=True)
    SORT_ORDER = models.FloatField(null=True, blank=True)  # Fixed
    GEOCODE = models.FloatField(null=True, blank=True)  # Fixed
    CS_CATEGORY = models.CharField(max_length=255, null=True, blank=True)
    MS_CATEGORY = models.CharField(max_length=255, null=True, blank=True)
    CIVIL_STATUS = models.CharField(max_length=255, null=True, blank=True)
    REGISTRATION_STATUS = models.CharField(max_length=255, null=True, blank=True)
    PCN = models.CharField(max_length=255, null=True, blank=True)
    PCN_REMARKS = models.CharField(max_length=255, null=True, blank=True)
    ARCHIVED_HEALTH_FACI = models.CharField(max_length=255, null=True, blank=True)
    HEALTH_FACI_REMARKS = models.CharField(max_length=255, null=True, blank=True)
    DATE_REASON_HEALTH = models.CharField(max_length=255, null=True, blank=True)
    CHILD_BENE = models.CharField(max_length=255, null=True, blank=True)
    STRANDS = models.CharField(max_length=255, null=True, blank=True)
    TRACKS = models.CharField(max_length=255, null=True, blank=True)
    ARCHIVED_EDUC_FACI = models.CharField(max_length=255, null=True, blank=True)
    SCHOOL_REMARKS = models.CharField(max_length=255, null=True, blank=True)
    DATE_REASON_EDUC = models.CharField(max_length=255, null=True, blank=True)
    LRN_REMARKS = models.CharField(max_length=255, null=True, blank=True)
    CCT_TYPE = models.CharField(max_length=255, null=True, blank=True)


    def __str__(self):
        return f"{self.FIRST_NAME} {self.LAST_NAME}"

    class Meta:
        db_table = 'tbl_roster' 

class dedupe_tagging(models.Model):
    ENTRY_ID = models.CharField(max_length=10, primary_key=True, null=False)

    # TAGGING
    # (0) NO DUPLICATE DETECTED
    # (1) Verified Duplicate - Records confirmed as exact duplicates based on rigorous matching criteria, such as unique identifiers or exact matches across critical fields.
    # (2) High-Confidence Duplicate - Records highly likely to be duplicates based on strong similarity in multiple key fields, such as name, email, and date of birth.
    # (3) Possible Duplicate - Records with moderate similarity, where some key fields match, but others are incomplete or slightly different (e.g., similar names with different spellings).
    # (4) Low-Confidence Duplicate - Records with minimal similarity, indicating a weak likelihood of duplication. For example, a partial match in non-critical fields.
    DUPE_TAGGING_ID = models.IntegerField(
        null=True, 
        default=0, 
        choices=[
            (0, 'No Duplicate Detected'),
            (1, 'Verified Duplicate'),
            (2, 'High-Confidence Duplicate'),
            (3, 'Possible Duplicate'),
            (4, 'Low-Confidence Duplicate')
        ]
    )
    USER_ID = models.IntegerField(null=True, default=0)
    DATE_TAG = models.DateTimeField(default=now)

    class Meta:
        db_table = 'tbl_dedupe_tags' 

class lib_dupe_tagging(models.Model):
    DUPE_TAGGING_ID = models.IntegerField(primary_key=True)  # Autonumber or manually defined ID
    DUPE_TAG = models.CharField(max_length=20, null=True, blank=True)
    TAG_DESCRIPTION = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"{self.DUPE_TAG} - {self.TAG_DESCRIPTION}"

    class Meta:
        db_table = 'lib_dedupe_tags' 