import unittest

import dungeon_nexus


class VersionTestCase(unittest.TestCase):
    """Version tests"""

    def test_version(self):
        """check dungeon_nexus exposes a version attribute"""
        self.assertTrue(hasattr(dungeon_nexus, "__version__"))
        self.assertIsInstance(dungeon_nexus.__version__, str)


if __name__ == "__main__":
    unittest.main()
