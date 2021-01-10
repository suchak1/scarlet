import sys
import pytest
from datetime import timedelta
sys.path.append('src')
from TimeMachine import TimeTraveller  # noqa autopep8

traveller = TimeTraveller()


class TestTimeTraveller:
    def test_convert_delta(self):
        assert traveller.convert_delta('1d') == timedelta(days=1)
        assert traveller.convert_delta('3d') == timedelta(days=3)

        assert traveller.convert_delta('1w') == timedelta(days=7)
        assert traveller.convert_delta('3w') == timedelta(days=21)

        assert traveller.convert_delta('1m') == timedelta(days=30)
        assert traveller.convert_delta('3m') == timedelta(days=90)

        assert traveller.convert_delta('1y') == timedelta(days=365)
        assert traveller.convert_delta('3y') == timedelta(days=1095)

        with pytest.raises(ValueError):
            traveller.convert_delta('0')

    def test_dates_in_range(self):
        assert len(traveller.dates_in_range('1m')) > 20
