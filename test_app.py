import unittest

from app import greeting


class AppTest(unittest.TestCase):
    def test_greeting_is_stable(self):
        self.assertEqual(greeting(), "Hello from Jenkins Docker Python app")

    def test_greeting_mentions_python(self):
        self.assertIn("Python", greeting())


if __name__ == "__main__":
    unittest.main()
