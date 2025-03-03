from models import *

def get_data(subset=100):
    try:
        records = (
            db.session.query(
                TblRoster.hh_id,
                TblRoster.entry_id,
                TblRoster.province,
                TblRoster.municipality,
                TblRoster.barangay,
                TblRoster.birthday,
                db.func.concat_ws(' ', TblRoster.first_name, TblRoster.middle_name, TblRoster.last_name).label('fullname')
            )
            .limit(subset)
            .all()
        )

        data = [
            {
                'fullname': r.fullname,
                'hh_id': r.hh_id,
                'entry_id': r.entry_id,
                'province': r.province,
                'municipality': r.municipality,
                'barangay': r.barangay,
                'birthday': r.birthday
            }
            for r in records
        ]

        return data, 200
    except Exception as e:
        return {'error': str(e)}, 500
    finally:
        db.session.close()

