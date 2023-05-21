"""Unit tests for the Unit classes"""

import unittest

import dungeon_nexus.unit


class UnitTest(unittest.TestCase):
    """Unit tests for the Unit class"""

    def setUp(self):
        self.unit_name = "Sir Galahad"

    def test_nama(self):
        """Check the unit exposes a name attribute"""
        unit = dungeon_nexus.unit.Unit(self.unit_name)
        self.assertTrue(hasattr(unit, "name"))
        self.assertIsInstance(unit.name, str)


class PartyTest(unittest.TestCase):
    """Unit tests for the Party class"""


class CharacterTest(unittest.TestCase):
    """Unit tests for the Character class"""


if __name__ == "__main__":
    unittest.main()
