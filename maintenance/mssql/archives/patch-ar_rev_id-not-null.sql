DROP INDEX /*i*/ar_revid ON /*_*/archive
ALTER TABLE /*_*/archive ALTER COLUMN ar_rev_id INT NOT NULL;
CREATE INDEX /*i*/ar_revid ON /*_*/archive (ar_rev_id);
