from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class TblRoster(db.Model):
    __tablename__ = 'tbl_roster'
    
    sort_order = db.Column(db.Integer, name='ï»¿SORT_ORDER')
    region = db.Column(db.String(255))
    province = db.Column(db.String(255))
    municipality = db.Column(db.String(255))
    barangay = db.Column(db.String(255))
    geocode = db.Column(db.Integer)
    hh_id = db.Column(db.String(255))
    entry_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(255))
    middle_name = db.Column(db.String(255))
    last_name = db.Column(db.String(255))
    ext_name = db.Column(db.String(255))
    birthday = db.Column(db.Date)
    age = db.Column(db.Integer)
    age_on_health = db.Column(db.Integer)
    age_on_educ = db.Column(db.Integer)
    sex = db.Column(db.String(255))
    client_status = db.Column(db.String(255))
    cs_code = db.Column(db.Integer)
    member_status = db.Column(db.String(255))
    ms_code = db.Column(db.Integer)
    relation_to_hh_head = db.Column(db.String(255))
    rel_hh_id = db.Column(db.Integer)
    civil_status = db.Column(db.String(255))
    grantee = db.Column(db.String(255))
    registration_status = db.Column(db.String(255))
    hh_set = db.Column(db.String(255))
    solo_parent = db.Column(db.String(255))
    ip_affiliation = db.Column(db.String(255))
    pcn = db.Column(db.String(255))
    pcn_remarks = db.Column(db.String(255))
    occupation = db.Column(db.String(255))
    pregnancy_status = db.Column(db.String(255))
    health_faci_code = db.Column(db.Integer)
    health_facility = db.Column(db.String(255))
    monitored_health = db.Column(db.String(255))
    archived_health_faci = db.Column(db.String(255))
    health_faci_remarks = db.Column(db.String(255))
    reason_for_not_attending_health = db.Column(db.String(255))
    date_reason_health = db.Column(db.String(255))
    child_bene = db.Column(db.String(255))
    grade_level = db.Column(db.String(255))
    strands = db.Column(db.String(255))
    tracks = db.Column(db.String(255))
    attend_school = db.Column(db.String(255))
    school_code = db.Column(db.Integer)
    school_name = db.Column(db.String(255))
    monitored_educ = db.Column(db.String(255))
    archived_educ_faci = db.Column(db.String(255))
    school_remarks = db.Column(db.String(255))
    reason_for_not_attending_educ = db.Column(db.String(255))
    date_reason_educ = db.Column(db.String(255))
    lrn = db.Column(db.Float)
    lrn_remarks = db.Column(db.String(255))
    disability_remarks = db.Column(db.String(255))
    final_disability = db.Column(db.String(255))
    cct_type = db.Column(db.String(255))
    disability = db.Column(db.String(255))
    mcctcategory = db.Column(db.String(255))

    def to_dict(self):
        """Convert model data to a dictionary"""
        return {column.name: getattr(self, column.name) for column in self.__table__.columns}


class TblDedupeTasks(db.Model):
    __tablename__ = 'tbl_dedupe_tasks'

    task_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    date_started = db.Column(db.DateTime, nullable=False)
    date_complete = db.Column(db.DateTime, nullable=True)
    number_of_rows = db.Column(db.Integer, nullable=False)

class TblDedupeResults(db.Model):
    __tablename__ = 'tbl_dedupe_results'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    task_id = db.Column(db.Integer, db.ForeignKey('tbl_dedupe_tasks.task_id', ondelete='CASCADE'), nullable=False)
    entry_id = db.Column(db.Integer, db.ForeignKey('tbl_roster.entry_id', ondelete='CASCADE'), nullable=False)
    duplicate_id = db.Column(db.Integer, nullable=False)
    similarity_score = db.Column(db.Float, nullable=False)
    dob_score = db.Column(db.Numeric(5, 2), nullable=False)
    address_score = db.Column(db.Numeric(5, 2), nullable=False)
    final_score = db.Column(db.Numeric(5, 2), nullable=False)
    tag = db.Column(db.Enum('validated_duplicate', 'high-possibility', 'low-possibility', 'no-match', name='tag_enum'), nullable=False)

    # Relationships
    task = db.relationship('TblDedupeTasks', backref=db.backref('results', lazy=True))
    roster_entry = db.relationship('TblRoster', backref=db.backref('dedupe_results', lazy=True))

    # Unique constraint for (task_id, entry_id)
    __table_args__ = (
        db.UniqueConstraint('task_id', 'entry_id', name='uq_task_entry'),
    )

class TblTestReadWrite(db.Model):
    __tablename__ = 'tbl_test'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50))
    score = db.Column(db.Integer, nullable=False)
    description = db.Column(db.String(50))
    dt = db.Column(db.Date)